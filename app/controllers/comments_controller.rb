class CommentsController < ApplicationController

  before_action :set_project
  before_action :set_comment, only: [:destroy]

  # Users who have donated can comment and delete their own comment
  # Admin can delete comments
  
	def create 
    @comment = @project.comments.new(comment_params)
    authorize_action_for @comment
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @project, notice: 'Comment was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

	def destroy
    authorize_action_for @comment
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @project }
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
    params.require(:reward).permit(:project_id, :body)
  end

end