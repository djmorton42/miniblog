class Admin::TestEmailController < Admin::AdminAreaController
  def create
    TestMailer.test.deliver_now
  
    redirect_to admin_root_url
  end
end
