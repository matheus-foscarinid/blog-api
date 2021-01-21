Rails.application.routes.draw do
  
  root 'posts#index'
  resources :users
  resources :tags
  resources :posts, except: [:new, :edit] do
    resources :comments, except: [:new, :edit]
  end

  # get "/posts", to: "posts#index"
  # post "/posts", to: "posts#create"
  # get "/posts/:id", to: "posts#show"
  # patch "/posts/:id", to: "posts#update"
  # put "/posts/:id", to: "posts#update"
  # delete "/posts/:id", to: "posts#destroy"

end
