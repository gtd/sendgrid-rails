module SendGrid
  class MailInterceptor
    def self.delivering_email(mail)
      sendgrid_header = mail.instance_variable_get(:@sendgrid_header)

      if sendgrid_header.nil?
        raise "sendgrid_header not found. Are you using the deprecated ActionMailer 2 API? You must call the ActionMailer 3.0 mail() method for sendgrid-rails to work"
      else
        sendgrid_header.add_recipients(mail.to)
        mail.header['X-SMTPAPI'] = sendgrid_header.to_json if sendgrid_header.data.present?
        mail.header['to'] = 'dummy@email.com'
      end
    end
  end
end
