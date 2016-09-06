class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_action :track_request
  around_action :add_expires_header
  before_action :populate_default_models

  def populate_default_models
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
    @settings = Setting.all.first
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
