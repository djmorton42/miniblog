class TestMailer < ApplicationMailer
  def test
    emails = User.pluck(:email)

    mail(to: emails, subject: "Test Email", from: mail_from)
  end
end
