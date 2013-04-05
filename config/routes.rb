Social::Application.routes.draw do

  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"

  resources :users do
    resources :businesses, :except => [:index,:show] do
      resources :scheduled_posts, :except => [:new,:index,:show]
    end
    collection do
          get 'change_password'
          put 'update_password'
      end
  end
  resources :contact_us,:only=>[:new,:create]
  resources :sessions, :only => [:new, :create, :destroy]
  resources :password_resets,:only => [:new,:create,:edit,:update]
  
  match "/signup" => "users#new", as: :signup
  match "/login" => "sessions#new", as: :login
  match "/logout" => "sessions#destroy", as: :logout
  match "/delayed_job" => DelayedJobWeb, :anchor => false
  match 'contact' => 'contact_us#new',:as=>:contact
  
  match "/comingsoon" => "static_pages#comingsoon", as: :comingsoon
  match "/toc" => "static_pages#toc", as: :toc
  match "/about" => "static_pages#about", as: :about
  match "/faq" => "static_pages#faq", as: :faq
  match "/privacy_policy" => "static_pages#privacy", as: :privacy

  match "users/:user_id/businesses/:id/social_profile" => "businesses#social_profile", as: :social_profile
  match "users/:user_id/social_accounts" => "users#social_accounts", as: :social_accounts
  match "users/:user_id/businesses/:id/remove_twitter" => "businesses#remove_twitter", as: :twitter_removal
  match "users/:user_id/businesses/:id/remove_facebook" => "businesses#remove_facebook", as: :facebook_removal
  match "/auth/twitter/callback" => "businesses#twitter_callback"
  #match "/auth/facebook/callback" => "businesses#facebook_callback"
  match "/auth/facebook/callback" => "users#facebook_callback"
  match "users/:user_id/businesses/:id/dashboard" => "content#index", as: :business_dashboard
  match "users/:user_id/businesses/:id/scheduled" => "content#scheduled_posts", as: :scheduled_posts
  #match "users/:user_id/businesses/:id/archived" => "content#archived", as: :archived_posts
  
  match "users/:user_id/businesses/:id/textual" => "content#textual", as: :textual_post
  # match "users/:user_id/businesses/:id/textual/tweet_now" => "content#tweet_now", as: :tweet_now
  # match "users/:user_id/businesses/:id/textual/tweet_media_now" => "content#tweet_media_now", as: :tweet_media_now
  # match "users/:user_id/businesses/:id/textual/post_to_fb" => "content#post_to_fb", as: :post_to_fb

  match "users/:user_id/businesses/:id/textual/post_now" => "content#post_now", as: :post_now
  match "users/:user_id/businesses/:id/textual/post_image_now" => "content#post_image_now", as: :post_image_now

  match "users/:user_id/businesses/:id/images" => "content#images", as: :image_post
  match "users/:user_id/businesses/:id/videos" => "content#videos", as: :video_post
  
  root to: "static_pages#home"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id))(.:format)'
end
