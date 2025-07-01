module Admin
  class CommentsController < BaseController
    before_action :set_comment, only: [:approve, :hide, :destroy]

    def index
      @comments = Comment.includes(:user, :commentable).order(created_at: :desc)
    end

    def pending
      @comments = Comment.pending.includes(:user, :commentable).order(created_at: :desc)
      render :index
    end

    def approved
      @comments = Comment.approved.includes(:user, :commentable).order(created_at: :desc)
      render :index
    end

    def approve
      @comment.update(status: :approved)
      redirect_to admin_comments_path, notice: "Comment approved."
    end

    def hide
      @comment.update(status: :hidden)
      redirect_to admin_comments_path, notice: "Comment hidden."
    end

    def destroy
      @comment.destroy
      redirect_to admin_comments_path, notice: "Comment deleted."
    end

    private

    def set_comment
      @comment = Comment.find(params[:id])
    end
  end
end
