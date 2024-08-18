Rails.application.routes.draw do
  post '/users', to: 'users#create'
  post '/users/sign_in_with_otp', to: 'users#sign_in_with_otp'
  post 'automations/request_link', to: 'automations#request_link'
  patch 'users/update_account_ids', to: 'users#update_account_ids'
end
