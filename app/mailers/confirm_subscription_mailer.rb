class ConfirmSubscriptionMailer < ApplicationMailer
  def send_confirm_subscription_email(subscription)
    @settings = Setting.get
    @subscription = subscription

    mail(
      to: subscription.email,
      subject: "'#{@settings.blog_title}' Subscription Confirmation",
      from: mail_from
    )
  end
end
