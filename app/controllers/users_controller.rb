class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = User.new(user_params.except(:unipile_email_account_id, :unipile_linkedin_account_id))
    user.generate_otp_secret

    if user.save
      logger.debug "User saved: #{user.inspect}"

      otp_token = user.generate_otp_token
      logger.debug "Generated OTP for user: #{otp_token}"

      user_data = user.as_json
      user_data['otp_token'] = otp_token

      render json: { message: 'Usuário criado com sucesso', user: user_data, otp_secret: user.otp_secret }, status: :created
    else
      logger.debug "User save failed: #{user.errors.full_messages}"
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def sign_in_with_otp
    user = User.find_by(email: params[:email])
    logger.debug "User found: #{user.inspect}"

    if user
      logger.debug "OTP provided: #{params[:otp_token]}"

      if user.verify_otp(params[:otp_token])
        render json: { message: 'Login bem-sucedido' }, status: :ok
      else
        logger.debug "OTP verification failed for user: #{user.email}"
        render json: { errors: 'OTP inválido' }, status: :unauthorized
      end
    else
      logger.debug "Email not found: #{params[:email]}"
      render json: { errors: 'Email não encontrado' }, status: :unauthorized
    end
  end

  def update_account_ids
    user = User.find_by(email: params[:email])

    if user
      user.assign_attributes(user_update_params)

      if user.save(validate: false)
        render json: { message: 'IDs atualizados com sucesso', user: user }, status: :ok
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: 'Usuário não encontrado' }, status: :not_found
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :unipile_email_account_id, :unipile_linkedin_account_id)
  end

  def user_update_params
    params.permit(:email, :unipile_email_account_id, :unipile_linkedin_account_id)
  end
end
