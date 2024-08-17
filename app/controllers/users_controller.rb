class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    def create
      user = User.new(user_params)
      user.generate_otp_secret
  
      if user.save
        render json: { message: 'Usuário criado com sucesso', user: user, otp_secret: user.otp_secret }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def sign_in_with_otp
      user = User.find_by(email: params[:email])
      
      if user
        if user.verify_otp(params[:otp])
          render json: { message: 'Login bem-sucedido' }, status: :ok
        else
          render json: { errors: 'OTP inválido' }, status: :unauthorized
        end
      else
        render json: { errors: 'Email não encontrado' }, status: :unauthorized
      end
    end
  
    private
    
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
  