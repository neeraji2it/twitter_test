Rails.application.routes.draw do
	resources :tweets do
		collection do
			get 'get_user_tweets'
		end
	end

	resources :profiles

	devise_for :users

	resources :home do
		collection do
			get 'search_user'
			get 'tweets'
		end
	end

	resources :following do
		collection do
			get 'follow'
			get 'unfollow'
			get 'following_list'
			get 'followers'
		end
	end

	resources :likes do
		collection do
			get 'like'
			get 'dislike'
		end
	end

	resources :comments do
		collection do
			post 'create_comment'
		end
	end

	devise_scope :user do
		authenticated :user do
			root to: "home#index", as: :authenticated_root
		end
		unauthenticated do
			root 'devise/sessions#new', as: :unauthenticated_root
		end
	end	

  match '/*a', to: 'application#not_found', via: [:get, :post, :put, :delete]
end
