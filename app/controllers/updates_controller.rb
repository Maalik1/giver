class UpdatesController < PrivateController

  before_action :set_project
  before_action :set_update, except: [:new, :create]

  def new
    @update = @project.updates.new
    authorize_action_for @update
  end

  def create 
    @update = @project.updates.new(update_params)
    authorize_action_for @update
    respond_to do |format|
      if @update.save
        format.html { redirect_to @project, notice: 'Update was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @update.update(update_params)
        format.html { redirect_to @project, notice: 'Your update have been edited.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @update.destroy
    respond_to do |format|
      format.html { redirect_to @project }
    end
  end

private

  def set_project
    @project = Project.find_by_slug(params[:project_id]) || not_found
  end

  def set_update
    @update = @project.updates.find(params[:id]) || not_found
    authorize_action_for @update
  end

  def update_params
    params.require(:update).permit(:project_id, :title, :content)
  end

end
