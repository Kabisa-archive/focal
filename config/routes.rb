Focal::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :burndowns, only: [:show] do
    resources :iterations, only: [:show] do
      get :print, on: :member
    end

  	member {
  		get :metrics
  	}
  end
end
