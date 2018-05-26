Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
<<<<<<< HEAD


namespace :v1 do

	post 'user/signin' => 'user_token#create'

	post 'user/signup', to: 'users#create'
	get 'user/all', to: 'users#index'
	get 'user', to: 'users#show'
	put 'user/edit', to: 'users#update'
	delete 'user/del', to: 'users#destroy'


end
=======
	namespace :v1 do
		resources :paintings
	end
>>>>>>> 67562002140f2e87d144fb21a70f46565ad5d4ab

end
