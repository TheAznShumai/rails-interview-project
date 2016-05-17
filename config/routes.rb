Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'
  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      resources :questions, only: [:show, :index]
    end
  end
end
