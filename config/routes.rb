Rails.application.routes.draw do
  
  root 'posts#index'
  resources :users
  resources :tags, except: [:new, :edit]
  resources :posts, except: [:new, :edit] do
    resources :comments, except: [:new, :edit]
  end

  post "/posts/:id/tag", to: "posts#link_tag"
  delete "/posts/:id/tag", to: "posts#unlink_tag"
  post "/users/login", to: "users#login"
  # get "/posts", to: "posts#index"rai
  # post "/posts", to: "posts#create"
  # get "/posts/:id", to: "posts#show"
  # patch "/posts/:id", to: "posts#update"
  # put "/posts/:id", to: "posts#update"
  # delete "/posts/:id", to: "posts#destroy"

end
