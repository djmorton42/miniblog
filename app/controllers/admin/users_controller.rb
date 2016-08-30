class Admin::UsersController < Admin::AdminAreaController
  def index
    @users = User.order(:name).all
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.create(entry_params)

    if @user.errors.any?
      render :new
    else
      redirect_to admin_users_path
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(entry_params)
    
    if @user.errors.any?
      render :new
    else
      redirect_to admin_users_path
    end
  end

  def edit
    @user = User.find(params[:id])

    render :new
  end

  private
  def entry_params
    params
      .require(:user)
      .permit(:input_password, :input_password_confirmation, :name, :email)
  end
end
