class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    set_article
  end

  # GET /comments/new
  def new
    @comment = Comment.new
    set_article
  end

  # GET /comments/1/edit
  def edit
    set_article
  end

  # POST /comments
  # POST /comments.json
  def create
    @article = Article.find_by_id(params[:article_id])
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    set_article
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to({ controller: 'articles', action: 'show', notice: 'Comment was successfully deleted.'}.merge(id: @article.id))  }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_article
      article_id = @comment.parent_id.present? ? @comment.parent_id : params[:article_id]
      @article = Article.find_by_id(article_id)
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      prepare_params
    end

    def prepare_params
      params[:comment][:parent_type]  ||= "Article"
      params[:comment][:parent_id]    ||= params[:article_id]
      params[:comment][:user_id]      ||= current_user.id
      params.require(:comment).permit(:type, :title, :content, :active, :parent_type, :parent_id, :user_id)
    end
end
