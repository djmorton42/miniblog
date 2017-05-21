class SubscriptionsController < ApplicationController
  skip_after_action :track_request

  def create
    subscription = Subscription.subscribe(subscription_params[:email])

    if subscription.errors.any?
        faulty_subscription_details = {
            email: subscription.email,
            errors: subscription.errors[:email]
        }

      session[:faulty_subscription] = faulty_subscription_details

      redirect_to(redirect_path)
    else
      subscription.send_subscription_email

      handle_success
    end
  rescue AlreadySubscribedError
    handle_success
  end

  def confirm_email
    token = params[:id]
    subscription = Subscription.find_by(confirm_token: token)

    if subscription
      subscription.update_attributes(confirmed: true)
      redirect_to(success_subscription_path(token))
    else
      redirect_to(not_found_subscription_path(token))
    end
  end

  def unsubscribe
    token = params[:id]
    subscription = Subscription.find_by(unsubscribe_token: token)

    if subscription
      Subscription.where(email: subscription.email).destroy_all
      redirect_to(unsubscribe_success_subscription_path(token))
    else
      redirect_to(unsubscribe_failure_subscription_path(token))
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:email)
  end

  def handle_success
    redirect_to(
      redirect_path,
      notice: 'Thank you for subscribing!  Check your email for confirmation details!'
    )
  end

  def redirect_path
    request.referer || root_path
  end
end
