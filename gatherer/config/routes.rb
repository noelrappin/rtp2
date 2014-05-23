Gatherer::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  resources :tasks do
    member do
      patch :up
      patch :down
    end
  end

  resources :projects
end
