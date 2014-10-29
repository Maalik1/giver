class MessagesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_message, only: [:show, :create, :destroy]
  
  def index; end

  def show; end
  
  def create 
    @message = @project.messages.new(message_params)
    respond_to do |format|
      if @message.save
        format.html { redirect_to @project, notice: 'Message was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to @project }
    end
  end

private

  def set_project
    @project = Project.find_by_slug(params[:project_id]) || not_found
  end

  def set_message
    @message = @project.messages.find(params[:id]) || not_found
  end

  def message_params
    params.require(:reward).permit(:project_id, :body)
  end

end