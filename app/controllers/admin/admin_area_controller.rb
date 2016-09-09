class Admin::AdminAreaController < ActionController::Base
  layout 'admin'
  
  before_action :check_authentication
  before_action :set_user_instance_from_session
                                                                                 
  def default_url_options
    if Rails.env.production?
      {host: ENV["MINIBLOG_HOST"], secure: true}
    else  
      {}
    end
  end
  
  def set_user_instance_from_session                                          
    current_user_id = session[:current_user_id]                             
    @current_user = current_user_id.nil? ? nil : User.find(current_user_id) 
  end                                                                         

  def check_authentication
    if session[:current_user_id].nil?
      redirect_to new_admin_authentications_path
    end
  end
end
