class Admin::AuthenticationsController < Admin::AdminAreaController
  skip_before_action :check_authentication, only: [:new, :create]

  def new
    @authentication = Authentication.new
  end

  def create
    @authentication = Authentication.create(
      email: params[:email],
      password: params[:password]
    )

    if @authentication.errors.size > 0
      render :new
    else
      session[:current_user_id] = @authentication.user.id
      @current_user = @authentication.user
      @current_user.update_attributes(last_login: DateTime.now)
    
      redirect_to admin_root_path
    end
  end

  def destroy
    if session[:current_user_id]
      session.delete(:current_user_id)
      @current_user = nil
    end
    redirect_to root_path
  end
end
