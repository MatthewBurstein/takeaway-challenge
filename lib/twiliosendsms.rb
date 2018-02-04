require 'twilio-ruby'

class TwilioSendSMS

  ACCOUNT_SID = ENV["TWILIO_ACCOUNT_SID"]
  AUTH_TOKEN = ENV["TWILIO_AUTH_TOKEN"]

  def self.send_sms(to_phone_number)
    client = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
    client.messages.create(
      body: message_body,
      to: to_phone_number,
      from: '+447403932186',
      )
  end

  private

  def self.message_body
    "Thank you for your order. It will be delivered before #{Time.now.strftime("%H:%M")}"
  end
end
