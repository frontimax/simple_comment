# rspec spec/controllers/users_controller_spec.rb

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  
  let! (:andy) { create :user, :andy }
  
  let(:valid_attributes) {
    {
      name: 'Max',
      email: 'max@online.de',
      password: 'sumcumo',
      password_confirmation: 'sumcumo'
    }
  }

  let(:invalid_attributes) {
    {
      name: '',
      email: 'max@'
    }
  }

  let(:valid_session) { {} }

  describe 'user is logged in' do
    
    before :each do
      login_with andy
    end
    
    describe "GET #index" do
      it "assigns all users as @users" do
        user = User.create! valid_attributes
        get :index, params: {}, session: valid_session
        expect(assigns(:users)).to include(user)
      end
    end
  
    describe "GET #show" do
      it "assigns the requested user as @user" do
        user = User.create! valid_attributes
        get :show, params: {id: user.to_param}, session: valid_session
        expect(assigns(:user)).to eq(user)
      end
    end
  
    describe "GET #new" do
      it "assigns a new user as @user" do
        get :new, params: {}, session: valid_session
        expect(assigns(:user)).to be_a_new(User)
      end
    end
  
    describe "GET #edit" do
      it "assigns the requested user as @user" do
        user = User.create! valid_attributes
        get :edit, params: {id: user.to_param}, session: valid_session
        expect(assigns(:user)).to eq(user)
      end
    end
  
    describe "POST #create" do
      context "with valid params" do
        it "creates a new User" do
          expect {
            post :create, params: {user: valid_attributes}, session: valid_session
          }.to change(User, :count).by(1)
        end
      
        it "assigns a newly created user as @user" do
          post :create, params: {user: valid_attributes}, session: valid_session
          expect(assigns(:user)).to be_a(User)
          expect(assigns(:user)).to be_persisted
        end
      
        it "redirects to the created user" do
          post :create, params: {user: valid_attributes}, session: valid_session
          expect(response).to redirect_to(User.last)
        end
      end
    
      context "with invalid params" do
        it "assigns a newly created but unsaved user as @user" do
          post :create, params: {user: invalid_attributes}, session: valid_session
          expect(assigns(:user)).to be_a_new(User)
        end
      
        it "re-renders the 'new' template" do
          post :create, params: {user: invalid_attributes}, session: valid_session
          expect(response).to render_template("new")
        end
      end
    end
  
    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          {
            name: 'Willy',
            email: 'willy@online.de'
          }
        }
      
        it "updates the requested user" do
          user = User.create! valid_attributes
          put :update, params: {id: user.to_param, user: new_attributes}, session: valid_session
          user.reload
          expect(assigns(:user)).to eq(user)
          expect(user.name).to eq 'Willy'
        end
      
        it "assigns the requested user as @user" do
          user = User.create! valid_attributes
          put :update, params: {id: user.to_param, user: valid_attributes}, session: valid_session
          expect(assigns(:user)).to eq(user)
        end
      
        it "redirects to the user" do
          user = User.create! valid_attributes
          put :update, params: {id: user.to_param, user: valid_attributes}, session: valid_session
          expect(response).to redirect_to(user)
        end
      end
    
      context "with invalid params" do
        it "assigns the user as @user" do
          user = User.create! valid_attributes
          put :update, params: {id: user.to_param, user: invalid_attributes}, session: valid_session
          expect(assigns(:user)).to eq(user)
        end
      
        it "re-renders the 'edit' template" do
          user = User.create! valid_attributes
          put :update, params: {id: user.to_param, user: invalid_attributes}, session: valid_session
          expect(response).to render_template("edit")
        end
      end
    end
  
    describe "DELETE #destroy" do
      it "destroys the requested user" do
        user = User.create! valid_attributes
        expect {
          delete :destroy, params: {id: user.to_param}, session: valid_session
        }.to change(User, :count).by(-1)
      end
    
      it "redirects to the users list" do
        user = User.create! valid_attributes
        delete :destroy, params: {id: user.to_param}, session: valid_session
        expect(response).to redirect_to(users_url)
      end
    end
    
    describe 'soap functions' do
      
      it 'edit#get_countries' do
        expect(Cccode::CountryCode.exists?).to be_falsey
        user = User.create! valid_attributes
        get :edit, params: {id: user.to_param}, session: valid_session
        expect(assigns(:user)).to eq(user)
        expect(Cccode::CountryCode.exists?).to be_truthy
        expect(assigns(:countries).size).to eq 244
      end

      it 'create#get_countries' do
        user = User.create! valid_attributes
        post :create, params: {user: valid_attributes}, session: valid_session
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:countries).size).to eq 244
      end

      context 'update' do
        let(:new_attributes) {
          {
            name: 'Willy',
            email: 'willy@online.de'
          }
        }

        it 'update#get_countries' do
          user = User.create! valid_attributes
          put :update, params: {id: user.to_param, user: new_attributes}, session: valid_session
          user.reload
          expect(assigns(:user)).to eq(user)
          expect(assigns(:countries).size).to eq 244
        end
      end
      
      it 'private methods' do
        c = UsersController.new
        controller.instance_variable_set(:@countries, c.send(:get_countries))
        expect(assigns(:countries).size).to eq 244
        controller.instance_variable_set(:@country, 'Germany')
        expect(assigns(:country)).to eq 'Germany'
      end
    end
    
  end
  
end
