Rails.application.routes.draw do
  root 'home#show'
  resources :chats, only: :show
end
