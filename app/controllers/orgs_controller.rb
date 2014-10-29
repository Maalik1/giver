class OrgsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show, :projects, :location]
  before_action :set_org, except: [:index, :new, :create]

  layout 'org', except: [:index, :new]

  def index
    @orgs = Org.all
  end

  def show; end

  def new
    @org = Org.new
    authorize_action_for @org
  end

  def create 
    @org = Org.new(org_params)
    authorize_action_for @org
    respond_to do |format|
      if @org.save
        format.html { redirect_to @org, notice: 'Org was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def edit
    authorize_action_for @org
  end

  def update
    authorize_action_for @org
    respond_to do |format|
      if @org.update(org_params)
        format.html { redirect_to @org, notice: 'Your organization\'s details have been updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    authorize_action_for @org
    @org.destroy
    respond_to do |format|
      format.html { redirect_to orgs_path }
    end
  end

  def admin; end

  def projects; end

  def location; end

private
	
  def set_org
    @org = Org.find_by_slug(params[:id]) || not_found
  end

  def org_params
    params.require(:org).permit(:name, :display_name, :ein, :photo, :description, :mission, :location, :tax_exempt, :bootsy_image_gallery_id)
  end

end
