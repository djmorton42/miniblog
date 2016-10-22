class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  after_action :track_request
  around_action :add_expires_header
  before_action :populate_default_models
  before_action :set_user_instance_from_session
                                                                                 
  def set_user_instance_from_session                                          
    current_user_id = session[:current_user_id]                             
    @current_user = current_user_id.nil? ? nil : User.find(current_user_id) 
  end                                                                         

  def populate_default_models
    renderer = Redcarpet::Render::HTML.new(escape_html: true)
    @markdown = Redcarpet::Markdown.new(renderer, extensions = {})
    @settings = Setting.all.first
    @categories = Category.order(:name).all
  end

  def track_request
    Tracker.create(
        status_code: response.status,
        user_agent: request.user_agent,
        source_ip: request.remote_ip,
        url: request.url,
        referer: request.referer,
        accept_language: request.accept_language,
        x_forwarded_for:  request.headers['x-forwarded-for']
    )
  end

  def add_expires_header
    yield
    response.headers["Expires"] = 1.hour.from_now.httpdate
  end
end
