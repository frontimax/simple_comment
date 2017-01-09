# rspec spec/controllers/comments_controller_spec.rb

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  
  let! (:andy) { create :user, :andy }
  let! (:article)    { create :article, :active, parent_id: andy.id, user_id: andy.id }
  
  let(:valid_attributes) {
    {
      title: 'My Title',
      content: 'My Content',
      parent_type: 'Article',
      parent_id: article.id,
      user_id: andy.id
    }
  }

  let(:invalid_attributes) {
    {
      title: '',
      content: ''
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CommentsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'user is logged in' do
    before :each do
      login_with andy
    end

    describe "GET #index" do
      it "assigns all comments as @comments" do
        comment = Comment.create! valid_attributes
        get :index, params: {}, session: valid_session
        expect(assigns(:comments)).to eq([comment])
      end
    end

    describe "GET #show" do
      it "assigns the requested comment as @comment" do
        comment = Comment.create! valid_attributes
        get :show, params: {id: comment.to_param}, session: valid_session
        expect(assigns(:comment)).to eq(comment)
      end
    end

    describe "GET #new" do
      it "assigns a new comment as @comment" do
        get :new, params: {}, session: valid_session
        expect(assigns(:comment)).to be_a_new(Comment)
      end
    end

    describe "GET #edit" do
      it "assigns the requested comment as @comment" do
        comment = Comment.create! valid_attributes
        get :edit, params: {id: comment.to_param}, session: valid_session
        expect(assigns(:comment)).to eq(comment)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Comment" do
          expect {
            post :create, params: {comment: valid_attributes}, session: valid_session
          }.to change(Comment, :count).by(1)
        end
    
        it "assigns a newly created comment as @comment" do
          post :create, params: {comment: valid_attributes}, session: valid_session
          expect(assigns(:comment)).to be_a(Comment)
          expect(assigns(:comment)).to be_persisted
        end
    
        it "redirects to the created comment" do
          post :create, params: {comment: valid_attributes}, session: valid_session
          expect(response).to redirect_to(Comment.last)
        end
      end
  
      context "with invalid params" do
        it "assigns a newly created but unsaved comment as @comment" do
          post :create, params: {comment: invalid_attributes}, session: valid_session
          current_user = andy
          expect(assigns(:comment)).to be_a_new(Comment)
        end
    
        it "re-renders the 'new' template" do
          post :create, params: {comment: invalid_attributes}, session: valid_session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          {
            title: 'My modified Title',
            content: 'My modified Content'
          }
        }
    
        it "updates the requested comment" do
          comment = Comment.create! valid_attributes
          put :update, params: {id: comment.to_param, comment: new_attributes}, session: valid_session
          comment.reload
          expect(assigns(:comment)).to eq(comment)
          expect(comment.title).to eq 'My modified Title'
        end
    
        it "assigns the requested comment as @comment" do
          comment = Comment.create! valid_attributes
          put :update, params: {id: comment.to_param, comment: valid_attributes}, session: valid_session
          expect(assigns(:comment)).to eq(comment)
        end
    
        it "redirects to the comment" do
          comment = Comment.create! valid_attributes
          put :update, params: {id: comment.to_param, comment: valid_attributes}, session: valid_session
          expect(response).to redirect_to(comment)
        end
      end
  
      context "with invalid params" do
        it "assigns the comment as @comment" do
          comment = Comment.create! valid_attributes
          put :update, params: {id: comment.to_param, comment: invalid_attributes}, session: valid_session
          expect(assigns(:comment)).to eq(comment)
        end
    
        it "re-renders the 'edit' template" do
          comment = Comment.create! valid_attributes
          put :update, params: {id: comment.to_param, comment: invalid_attributes}, session: valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested comment" do
        comment = Comment.create! valid_attributes
        expect {
          delete :destroy, params: {id: comment.to_param}, session: valid_session
        }.to change(Comment, :count).by(-1)
      end
  
      it "redirects to the comments list" do
        comment = Comment.create! valid_attributes
        delete :destroy, params: {id: comment.to_param}, session: valid_session
        expect(response).to redirect_to("http://test.host/articles/1?notice=Comment+was+successfully+deleted.")
      end
    end
  end
  
end
