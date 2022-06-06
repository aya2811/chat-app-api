Rails.application.routes.draw do
  namespace 'api' do
    resources :apps do
      resources :chats do
        resources :messages
      end
    end
  end
end
