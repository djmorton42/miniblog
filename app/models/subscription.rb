class Subscription < ActiveRecord::Base
    validates :email, presence: { message: "Subscription email is required" }
    validates :email, email: { message: "Must be a validly formatted email address" }, if: -> (sub) { sub.errors[:email].empty? }

    def self.subscribe(email)
        raise AlreadySubscribedError if Subscription.where(email: email, confirmed: true).any?

        Subscription.create(
            email: email,
            confirmed: false,
            confirm_token: SecureRandom.hex(16),
            unsubscribe_token: SecureRandom.hex(16)
        )
    end

    def send_subscription_email
        ConfirmSubscriptionMailer.send_confirm_subscription_email(self).deliver_now
    end
end
