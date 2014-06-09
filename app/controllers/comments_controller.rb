class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build comment_params
    @comment.save

    redirect_to @comment.commentable, :notice => "Comentário criado com sucesso!"
  end

  private

  def comment_params
    params.require(:comment).permit([:text, :commentable_type, :commentable_id])
  end
end
