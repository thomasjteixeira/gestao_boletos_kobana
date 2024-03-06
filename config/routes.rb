# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :bank_billets do
    get 'mock_data', on: :collection
    member do
      post 'cancel'
      post 'pay'
    end
  end

  root 'bank_billets#index'
end
