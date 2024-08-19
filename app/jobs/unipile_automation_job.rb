class UnipileAutomationJob
  include Sidekiq::Job

  def perform(account_id, email_params, linkedin_message_params, linkedin_connection_params)
    unipile_service = UnipileService.new(User.find_by(account_id: account_id))

    unipile_service.send_email(
      email_params[:account_id],
      email_params[:from],
      email_params[:to],
      email_params[:subject],
      email_params[:body],
      email_params[:cc],
      email_params[:bcc],
      email_params[:reply_to],
      email_params[:custom_headers],
      email_params[:tracking_options],
      email_params[:attachments]
    )

    unipile_service.start_linkedin_chat(
      linkedin_message_params[:account_id],
      linkedin_message_params[:text],
      linkedin_message_params[:attendees_ids],
      linkedin_message_params[:subject],
      linkedin_message_params[:voice_message],
      linkedin_message_params[:attachments]
    )

    loop do
      response = unipile_service.create_linkedin_connections(
        linkedin_connection_params[:cursor],
        linkedin_connection_params[:limit],
        linkedin_connection_params[:account_id]
      )
      break if response["data"].empty? || response["cursor"].nil?
      linkedin_connection_params[:cursor] = response["cursor"]
    end
  end
end