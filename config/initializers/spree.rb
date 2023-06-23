# Configure Solidus Preferences
# See http://docs.solidus.io/Spree/AppConfiguration.html for details

# Solidus version defaults for preferences that are not overridden
Spree.load_defaults '3.3.1'

Spree.config do |config|
  # Core:
  config.currency = "USD"
  config.image_attachment_module = 'Spree::Image::ActiveStorageAttachment'
  config.taxon_attachment_module = 'Spree::Taxon::ActiveStorageAttachment'
  config.mails_from = 'cmoikvolelorange@gmail.com' # This will be used for registration emails, etc.

  config.mailer_sender = "cmoikvolelorange@gmail.com"

  config.override_actionmailer_config = true
  config.enable_mail_delivery = true

  ActionMailer::Base.smtp_settings = {
    :address => "smtp.gmail.com",
    :port => 587,
    :domain => "gmail.com",
    :user_name => ENV['GMAIL_USERNAME'],
    :password => ENV['GMAIL_PASSWORD'],
    :authentication => :login,
    :enable_starttls_auto => true
  }
end

Spree::Backend::Config.configure do |config|
  config.locale = 'en'
end

Spree::Api::Config.configure do |config|
  config.requires_authentication = true
end
