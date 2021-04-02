class ApplicationMailer < ActionMailer::Base
  default from: "Bizu <nao-responda@#{ENV['HOST_URL']}>"
  layout 'mailer'
end
