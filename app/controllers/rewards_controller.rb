class RewardsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_reward, except: [:new, :create]
  
  layout 'project'

  def new
    @reward = @project.rewards.new
    authorize_action_for @reward
  end

  def create 
    @reward = @project.rewards.new(reward_params)
    authorize_action_for @reward
    respond_to do |format|
      if @reward.save
        format.html { redirect_to @project, notice: 'Reward was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @reward.update(reward_params)
        format.html { redirect_to @project, notice: 'Your reward have been edited.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @reward.destroy
    respond_to do |format|
      format.html { redirect_to @project }
    end
  end

private

  def set_project
    @project = Project.find_by_slug(params[:project_id]) || not_found
  end

  def set_reward
    @reward = @project.rewards.find(params[:id]) || not_found
    authorize_action_for @reward
  end

  def reward_params
    params.require(:reward).permit(:project_id, :amount, :description, :shipping, :delivery_date, :limit, :limit_number)
  end

end