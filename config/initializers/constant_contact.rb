# setting config options for constant contact api

ConstantContact::Util::Config.configure do |config|
  config[:auth][:api_key]      = ENV['API_CC_KEY']
  config[:auth][:api_secret]   = ENV['API_CC_SECRET']
  config[:auth][:redirect_uri] = 'http://www.callowayart.com/auth/constantcontact'
end