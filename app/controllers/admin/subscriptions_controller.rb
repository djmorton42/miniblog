class Admin::SubscriptionsController < Admin::AdminAreaController
  def show
    @subscriptions = Subscription.where(confirmed: true).order(:email).pluck(:email, :created_at)
  end
end
