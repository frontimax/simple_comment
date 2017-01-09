class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    get_countries
  end

  # GET /users/1/edit
  def edit
    get_countries
  end

  # POST /users
  # POST /users.json
  def create
    #get_countries
    #set_country_values(params[:user][:country])
    Rails.logger.debug("xxx - create - user_params: #{user_params}")
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    get_countries
    set_country_values(params[:user][:country])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    # todo: transfer logic to model if possible, add error flashes
    if prevent_own
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'You can not delete youself, pal!' }
        format.json { head :no_content }
      end
    elsif prevent_admin
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'You can not delete master admin, pal!' }
        format.json { head :no_content }
      end
    else
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully deleted.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      check_change_password
      params.fetch(:user, {}).permit(
        :name,
        :email,
        :active,
        :country,
        :country_code,
        :currency,
        :currency_code,
        :password,
        :password_confirmation,
        :admin_role
      )
    end
  
    def check_change_password
      if params[:change_password].blank? && (@user && @user.password.present?)
        params[:user][:password] = @user.password
        params[:user][:password_confirmation] = @user.password
      end
    end
  
    def prevent_own
      current_user == @user
    end

    def prevent_admin
      @user.name == 'admin'
    end
  
  
  
    # todo: move this to concern or lib later! ######################### !!!
    def get_countries
      begin
        create_savon_client
        response = @client.call(:get_countries)
        result = response.hash[:envelope][:body][:get_countries_response][:get_countries_result]
        xml = Nokogiri::XML(result)
        @countries = xml.css('Table').map{|e| e.content.strip}
      rescue StandardError => e
        # ...
      end
    end
  
    def get_country_codes
      begin
        response = @client.call(:get_iso_country_code_by_county_name, :message => {"CountryName" => @country})
        result = response.hash[:envelope][:body][:get_iso_country_code_by_county_name_response][:get_iso_country_code_by_county_name_result]
        xml = Nokogiri::XML(result)
        @country_code = xml.css('Table/CountryCode').first.content
      rescue StandardError => e
        # ...
      end
    end
  
    def get_currency
      begin
        response = @client.call(:get_currency_by_country, :message => {"CountryName" => @country})
        result = response.hash[:envelope][:body][:get_currency_by_country_response][:get_currency_by_country_result]
        xml = Nokogiri::XML(result)
        @currency = xml.css('Table/Currency').first.content
      rescue StandardError => e
        # ...
      end
    end
  
    def get_currency_code
      return unless @currency
      response = @client.call(:get_currency_code_by_currency_name, :message => {"CurrencyName" => @currency})
      result = response.hash[:envelope][:body][:get_currency_code_by_currency_name_response][:get_currency_code_by_currency_name_result]
      xml = Nokogiri::XML(result)
      @currency_code = xml.css('Table/CurrencyCode').first.content
    end
  
    def create_savon_client
      begin
        @client = Savon.client(wsdl: 'http://www.webservicex.net/country.asmx?WSDL')
      rescue StandardError => e
        # ...
      end
    end
  
    def set_country_values(country)
      @country = country
      if @countries.present?
        get_country_codes
        get_currency
        get_currency_code
        params[:user][:country_code]  = @country_code   if @country_code.present?
        params[:user][:currency]      = @currency       if @currency.present?
        params[:user][:currency_code] = @currency_code  if @currency_code.present?
      end
    end
end
