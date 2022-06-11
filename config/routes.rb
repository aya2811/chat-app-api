Rails.application.routes.draw do
  namespace 'api' do
    resources :apps do
      resources :chats do
        resources :messages do
          collection do
            get :search
          end
        end
      end
    end
  end
end
