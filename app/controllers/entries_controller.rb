require 'net/https'

class EntriesController < ApplicationController
  class RecaptchaError < StandardError; end

  def show
    @entry = Entry.find(params[:id])
    @comment = Comment.new

    can_view_entry(@entry)
  end

  def add_comment
    @entry = Entry.find(params[:entry_id])
    can_view_entry(@entry)

    unless @entry.allow_comments
      render(text: "Adding comments is disallowed for this blog post.", status: :forbidden) and return
    end

    @comment = Comment.new(comment_params)
    @comment.is_approved = !Setting.get.require_comment_approval
    @comment.entry = @entry

    begin
      verify_recaptcha(params['g-recaptcha-response'])
      @comment.save
    rescue RecaptchaError => e
      logger.warn("Recaptcha Error: #{e.message}")
      render(text: 'Sorry, you might be a robot!', status: :forbidden) and return
    end

    if @comment.errors.any?
      render :show
    else
      CommentNotificationMailer.comment_notification(@comment, @entry).deliver_later
      redirect_to entry_url(@entry)
    end
  end

  def can_view_entry(entry)
    raise ActionController::RoutingError.new('Not Found') if entry.is_deleted
    raise ActionController::RoutingError.new('Not Found') unless entry.is_published || session[:current_user_id].present?
  end

  private

  def verify_recaptcha(g_recaptcha_response)
    params = {
      secret: ENV['RECAPTCHA_SECRET'],
      response: g_recaptcha_response,
      remoteip: request.remote_ip
    }
    recaptcha_endpoint = 'https://www.google.com/recaptcha/api/siteverify'
    recaptcha_response = Net::HTTP.post_form(URI.parse(recaptcha_endpoint), params)

    logger.warn("Recaptcha Result: #{recaptcha_response.body}")

    response_json = JSON.parse(recaptcha_response.body).with_indifferent_access

    raise RecaptchaError, "Unsuccessful Recaptcha" unless response_json[:success]
    raise RecaptchaError, "Invalid Recaptcha Hostname" unless valid_recaptcha_domain(response_json[:hostname])
    raise RecaptchaError, "Recaptcha Timestamp to distant" unless validate_recaptcha_ts(response_json)
  end

  def validate_recaptcha_ts(response_json)
    now = Time.now.utc
    parsed_time = Time.parse(response_json[:challenge_ts])

    logger.warn("Recaptcha Time Check: Now: #{now} - Challenge Time: #{parsed_time}")

    return (now - parsed_time) < 60
  end

  def valid_recaptcha_domain(domain)
    ENV['RECAPTCHA_DOMAINS'].split('|').include?(domain)
  end

  def comment_params
    params
      .require(:comment)
      .permit(:commenter_name, :comment, :response_to_comment_id)
  end
end
