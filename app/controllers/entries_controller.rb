class EntriesController < ApplicationController
  def show
    @entry = Entry.find(params[:id])
    @comment = Comment.new

    can_view_entry(@entry)
  end

  def add_comment
    @entry = Entry.find(params[:entry_id])
    can_view_entry(@entry)

    unless @entry.allow_comments 
      render(text: "Adding comments is disallowed for this blog post.", status: :forbidden) and return
    end

    @comment = Comment.new(comment_params)
    @comment.is_approved = !Setting.get.require_comment_approval
    @comment.entry = @entry
    @comment.save

    if @comment.errors.any?
      render :show
    else
      redirect_to entry_url(@entry)
    end
  end

  def can_view_entry(entry)
    raise ActionController::RoutingError.new('Not Found') if entry.is_deleted
    raise ActionController::RoutingError.new('Not Found') unless entry.is_published || session[:current_user_id].present?
  end

  private
  def comment_params
    params
      .require(:comment)
      .permit(:commenter_name, :comment, :response_to_comment_id)
  end 
end
