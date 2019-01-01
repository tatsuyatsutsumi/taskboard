Rails.application.routes.draw do
  devise_for :users
  root 'top#index'

  # ==========ここから編集する==========
  resources :list, only: %i(new create edit update destroy) do
    resources :card, only: %i(new create)
  end
  # ==========ここまで編集する==========

end