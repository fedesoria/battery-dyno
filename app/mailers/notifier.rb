class Notifier < ActionMailer::Base
  default :from => "alerts@dynobattery.com"
  
  def alert_email(user, percentage)
    @app = user.name
    @percentage = percentage
    mail(:to => user.email, :subject => "Your application #{user.name} is running low on dynos")
  end
end
