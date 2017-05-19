class ApplicationMailer < ActionMailer::Base
  layout 'mailer'

  def mail_from
    "#{Setting.get.blog_title} <noreply@quadrilateral.ca>"
  end

  def create_markdown_renderer
    renderer = Redcarpet::Render::HTML.new(escape_html: true, hard_wrap: true)
    @markdown = Redcarpet::Markdown.new(renderer, extensions = {})
  end
end
