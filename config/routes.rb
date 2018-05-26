Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


namespace :v1 do

	post 'user/signin' => 'user_token#create'

	post 'user/signup', to: 'users#create'
	get 'user/all', to: 'users#index'
	get 'user', to: 'users#show'
	put 'user/edit', to: 'users#update'
	delete 'user/del', to: 'users#destroy'


end

end
