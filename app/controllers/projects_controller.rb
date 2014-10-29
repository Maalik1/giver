class ProjectsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show, :short_link]
  before_action :set_project, except: [:index, :new, :create]
  before_action :set_index, only: :index

  layout 'project', except: [:index, :new]

  def index; end

  def show; end

  def new
    @project = Project.new
    @orgs = (current_user.admin?) ? Org.all : current_user.orgs
    authorize_action_for @project
  end

  def create 
    @project = Project.new(project_params)
    authorize_action_for @project
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def edit
    authorize_action_for @project
  end

  def update
    authorize_action_for @project
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Your project details have been updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    authorize_action_for @project
    @project.update(active: false)
    respond_to do |format|
      format.html { redirect_to projects_path }
    end
  end

  def short_link
    redirect_to project_path(@project)
  end

private

  def set_index
    if params.has_key?(:org)
      @org = Org.find_by_slug(params[:org]) || not_found
      @projects = @org.projects
    else
      @projects = Project.all
    end
  end

  def set_project
    @project = Project.find_by_slug(params[:id]).decorate || not_found
  end

  def project_params
    params.require(:project).permit(:org_id, :title, :photo, :video, :blurb, :story, :challenges, :location, :starts, :ends, :goal, :active, :bootsy_image_gallery_id)
  end

end
