class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    cache_for 60

    @listings = Statement.home
  end

  def join

    if params[:email].present? && params[:email] =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      client  = ConstantContact::Api.new ENV['API_CC_KEY']
      
      contact = { }
      contact['email_addresses'] = [ { 'email_address' => params[:email]} ]
      contact['addresses'] = []
      contact['lists'] = [ { 'id' => '2' } ]

      contact = ConstantContact::Components::Contact.create(contact)

      # add the contact
      begin
        client.add_contact ENV['API_CC_TOKEN'], contact

      rescue
      end
    end

    redirect_to request.referer
  end

  def design
  end

  def contact
    # deliver submission and redirect if email and referer
    # are present; the two actions are independant of one 
    # another 
    # TODO: this is a hack until we encapsulate mail send to
    # its own controller
    deliver_submission           if params[:email].present?
    redirect_to params[:referer] if params[:referer].present?

  end

  def about
  end

  private
    def deliver_submission
      ContactMailer.simple_inquiry( params ).deliver
    end

end
