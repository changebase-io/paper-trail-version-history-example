# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :posts do
    resources :versions, only: %i[index show update]
  end

  root 'application#home'
end
