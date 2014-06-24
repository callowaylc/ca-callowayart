class ContactMailer < ActionMailer::Base
  default from: 'notifications@callowayart.com'
  default to:   'susan@callowayart.com'

  def simple_inquiry(hash = { })

    # add view variables
    @name  = hash[:name]
    @email = hash[:email]
    @inquiry = hash[:inquiry]

    #TODO: replace values with constants
    mail subject: 'inquiry from callowayart.com'
  end
end
