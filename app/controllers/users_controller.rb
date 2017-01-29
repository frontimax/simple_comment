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
    get_countries
    set_country_values(params[:user][:country])
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
    # todo: transfer logic to model if possible, add error flashes‚
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
      if params[:change_password].blank? && (@user && @user.id.present?)
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
    end
  
    def prevent_own
      current_user == @user
    end

    def prevent_admin
      @user.name == 'admin'
    end
  
    def get_countries
      Cccode.get_all if !Cccode::CountryCode.exists?
      @countries = Cccode.get_countries
    end
  
    def create_savon_client
      begin
        @client = Savon.client(wsdl: 'http://www.webservicex.net/country.asmx?WSDL')
      rescue StandardError => e
        # ...
      end
    end
  
    def set_country_values(country)
      return unless country
      params[:user][:country_code]  = Cccode.get_country_code(country)
      params[:user][:currency]      = Cccode.get_currency(country)
      params[:user][:currency_code] = Cccode.get_currency_code(@currency)  if params[:user][:currency].present?
    end
end
