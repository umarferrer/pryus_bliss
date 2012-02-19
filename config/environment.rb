# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
PryusBliss::Application.initialize!  

ActionMailer::Base.smtp_settings = {
  :address  => "smtp.gmail.com",
  :port  => 25,
  :user_name  => "pryusbliss@gmail.com",
  :password  => "pryusbliss",
  :authentication  => :login
}
