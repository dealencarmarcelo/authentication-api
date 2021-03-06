Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :auth, only: [] do
        collection do
          post :login
          post :register
        end
      end

      resources :users
    end
  end

end
