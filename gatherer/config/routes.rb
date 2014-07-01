Gatherer::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  devise_for :users
  resources :tasks do
    member do
      patch :up
      patch :down
    end
  end

  resources :projects

  root to: "projects#index"
end
