Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :authentication, only: [] do
        collection do
          post :login
        end
      end

      resources :users
    end
  end

end
