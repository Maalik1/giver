class UsersController < PrivateController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by_slug(params[:id])
  end

private

  def user_params
    params.require(:user).permit(:name, :first_name, :last_name, :photo, :email, org_attributes: [:id, :name])
  end

end
