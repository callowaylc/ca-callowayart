class ContactMailer < ActionMailer::Base
  default from: 'notifications@callowayart.com'
  default to:   'gallery@callowayart.com'

  def simple_inquiry(hash = { })

    # add view variables
    @name  = hash[:name]
    @email = hash[:email]
    @inquiry = hash[:inquiry]

    #TODO: replace values with constants
    mail subject: 'inquiry from callowayart.com',
         tag:     'inquiry'
  end
end
