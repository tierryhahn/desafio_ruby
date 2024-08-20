class StartLinkedinChatJob < ApplicationJob
  queue_as :default

  def perform(account_id, text, attendees_ids, subject = nil, voice_message = nil, attachments = [])
    UnipileService.new.start_linkedin_chat(account_id, text, attendees_ids, subject, voice_message, attachments)
  end
end