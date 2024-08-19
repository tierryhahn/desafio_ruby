Rails.application.routes.draw do
  post '/users', to: 'users#create'
  post '/users/sign_in_with_otp', to: 'users#sign_in_with_otp'
  post 'automations/request_link', to: 'automations#request_link'
  patch 'users/update_account_ids', to: 'users#update_account_ids'
  post 'automations/send_linkedin_message', to: 'automations#send_linkedin_message'
  post 'automations/send_email', to: 'automations#send_email'
  get 'attendees', to: 'automations#list_attendees'
  get 'chats', to: 'automations#list_chats'
end
