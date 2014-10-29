class CommentsController < ApplicationController
  
  before_action :authenticate_user!, except: [:index]
  before_action :set_project
  before_action :set_comment, only: [:destroy]

  layout 'project'
  
  def index; end
  
  def create 
    # render text: params.inspect
    @comment = @project.comments.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to project_comments_path(@project) }
      else
        format.html { redirect_to project_comments_path(@project), alert: "Error: #{@comment.errors.full_messages.to_sentence}" }
      end
    end
  end

  def destroy
    authorize_action_for @comment
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to project_comments_path(@project) }
    end
  end

private

  def set_project
    @project = Project.find_by_slug(params[:project_id]) || not_found
  end

  def set_comment
    @comment = @project.comments.find(params[:id]) || not_found
  end

  def comment_params
    params.require(:comment).permit(:user_id, :project_id, :body)
  end

end