DataEngineering::Application.routes.draw do
  resources :uploaders, only: [:new, :create, :index]

  root 'uploaders#new'
end
