class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(account_id, from, to, subject, body, cc = [], bcc = [], reply_to = nil, custom_headers = [], tracking_options = {}, attachments = [])
    UnipileService.new.send_email(account_id, from, to, subject, body, cc, bcc, reply_to, custom_headers, tracking_options, attachments)
  end
end