class Admin::AuthenticationsController < Admin::AdminController
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
    
      redirect_to admin_path
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
