class CommentsController < ApplicationController
  def index
    @comments = Comment.hash_tree
  end

  def new
    if current_user
      @user_id = current_user.id
      @comment = Comment.new(parent_id: params[:parent_id])
      respond_to do |format|
        format.js { render :comment_new }
      end
    else
      respond_to do |format|
        format.js { render :comment_log_in_required }
      end
    end
  end

  def hide
    respond_to do |format|
      format.js { render :comment_hide}
    end
  end

  def show
    @comments = Comment.flatten_nested_hash(Comment.hash_tree)
    respond_to do |format|
      format.js { render :comment_show }
    end
  end

  def create
    if params[:comment][:parent_id].to_i > 0
    parent = Comment.find_by_id(params[:comment].delete(:parent_id))
    @comment = parent.children.build(comment_params)
    else
      @comment = Comment.new(comment_params)
    end

    if @comment.save
      @last_comment = Comment.all.where(author: params["comment"]["author"], body: params["comment"]["body"]).last
      respond_to do |format|
        format.js { render :comment_last }
      end
    else
      render 'new'
    end
  end


  private

    def comment_params
      params.require(:comment).permit(:title, :body, :author, :user_id)
    end

end
