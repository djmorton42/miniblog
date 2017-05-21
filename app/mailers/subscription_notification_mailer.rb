class SubscriptionNotificationMailer < ApplicationMailer
  include ApplicationHelper

  helper_method :format_datetime

  def send_publish_notification(subscription_details_map, entry)
    @settings = Setting.get
    @entry = entry
    @unsubscribe_token = subscription_details_map[:unsubscribe_token]
    @markdown = create_markdown_renderer

    mail(
      to: subscription_details_map[:email],
      subject: "New blog post on #{@settings.blog_title}",
      from: mail_from
    )
  end
end
