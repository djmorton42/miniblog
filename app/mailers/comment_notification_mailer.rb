class CommentNotificationMailer < ApplicationMailer
  def comment_notification(comment, entry)
    @comment = comment
    @entry = entry

    emails = User.pluck("email")

    mail(
      to: emails,
      subject: "New Comment Received",
      from: mail_from
    )
  end
end
