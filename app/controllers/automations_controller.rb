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
  