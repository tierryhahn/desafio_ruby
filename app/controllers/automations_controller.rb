class AutomationsController < ApplicationController
  before_action :authenticate_user

  def request_link
    unipile_service = UnipileService.new(current_user)

    begin
      result = unipile_service.request_automation_link(params[:email], params[:otp_token])
      render json: { message: 'Link de automação solicitado com sucesso', data: result }, status: :ok
    rescue => e
      render json: { errors: e.message }, status: :unprocessable_entity
    end
  end

  def send_linkedin_message
    unipile_service = UnipileService.new(current_user)
  
    email = params[:email]
    otp_token = params[:otp_token]
    unless current_user.email == email && current_user.verify_otp(otp_token)
      render json: { errors: 'Autenticação falhou' }, status: :unauthorized
      return
    end
  
    begin
      chats_response = unipile_service.list_chats
      valid_attendees_ids = chats_response.fetch('data', []).map { |chat| chat['attendee_provider_id'] }.compact
  
      puts "Valid attendees IDs: #{valid_attendees_ids}"
  
      if valid_attendees_ids.empty?
        render json: { errors: 'No valid attendees found' }, status: :unprocessable_entity
        return
      end
  
      attendees_ids = params[:attendees_ids].map(&:strip).uniq
      invalid_ids = attendees_ids - valid_attendees_ids
  
      if invalid_ids.any?
        render json: { errors: "Invalid recipient IDs: #{invalid_ids.join(', ')}" }, status: :unprocessable_entity
        return
      end
  
      result = unipile_service.start_linkedin_chat(
        params[:account_id],
        params[:text],
        attendees_ids,
        params[:subject],
        params[:voice_message],
        params[:attachments] || []
      )
      render json: { message: 'Mensagem enviada com sucesso', data: result }, status: :ok
    rescue => e
      puts e.backtrace.join("\n")
      render json: { errors: e.message }, status: :unprocessable_entity
    end
  end

  def list_attendees
    unipile_service = UnipileService.new(current_user)

    begin
      result = unipile_service.list_attendees
      render json: { message: 'Lista de attendees recuperada com sucesso', data: result }, status: :ok
    rescue => e
      render json: { errors: e.message }, status: :unprocessable_entity
    end
  end

  def list_chats
    unipile_service = UnipileService.new(current_user)

    begin
      result = unipile_service.list_chats
      render json: { message: 'Lista de chats recuperada com sucesso', data: result }, status: :ok
    rescue => e
      render json: { errors: e.message }, status: :unprocessable_entity
    end
  end

  def send_email
    unipile_service = UnipileService.new(current_user)
  
    email = params[:email]
    otp_token = params[:otp_token]
  
    unless current_user.email == email && current_user.verify_otp(otp_token)
      render json: { errors: 'Autenticação falhou' }, status: :unauthorized
      return
    end
  
    begin
      from = {
        display_name: params[:from][:display_name],
        identifier: params[:from][:identifier]
      }
      
      to = params[:to].map do |recipient|
        {
          display_name: recipient[:display_name],
          identifier: recipient[:identifier]
        }
      end
      
      cc = params[:cc] || []
      bcc = params[:bcc] || []
      subject = params[:subject]
      body = params[:body]
      reply_to = params[:reply_to]
      custom_headers = params[:custom_headers] || []
      tracking_options = params[:tracking_options] || {}
      attachments = params[:attachments] || []
  
      result = unipile_service.send_email(
        params[:account_id],
        from,
        to,
        subject,
        body,
        cc,
        bcc,
        reply_to,
        custom_headers,
        tracking_options,
        attachments
      )
      render json: { message: 'Email enviado com sucesso', data: result }, status: :ok
    rescue => e
      render json: { errors: e.message }, status: :unprocessable_entity
    end
  end

  private

  def authenticate_user
    if params[:email].present? && params[:otp_token].present?
      user = User.find_by(email: params[:email])

      if user
        if user.verify_otp(params[:otp_token])
          @current_user = user
        else
          render json: { errors: 'Autenticação falhou' }, status: :unauthorized
        end
      else
        render json: { errors: 'Autenticação falhou' }, status: :unauthorized
      end
    else
      render json: { errors: 'Parâmetros inválidos' }, status: :unprocessable_entity
    end
  end

  def current_user
    @current_user
  end
end
