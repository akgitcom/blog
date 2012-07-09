class WelcomeMail < ActionMailer::Base
  default from: "aksoft@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.welcome_mail.welcome.subject
  #
  def welcome
    @greeting = "Hi"

    mail to: "aksoft@163.com"
  end
end
