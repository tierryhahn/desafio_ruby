Rails.application.routes.draw do
  post '/users', to: 'users#create'
  post '/users/sign_in_with_otp', to: 'users#sign_in_with_otp'
end
