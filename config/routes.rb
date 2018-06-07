Rails.application.routes.draw do
  
  mount ForestLiana::Engine => '/forest'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
# <<<<<<< HEAD
namespace :v1 do

	post 'user/signin' => 'user_token#create'

	post 'user/signup', to: 'users#create', as: 'signup_path'
	get 'user/all', to: 'users#index', as: 'user_all_path'
	get 'user', to: 'users#show', as: 'show_user_path'
	put 'user/edit', to: 'users#update', as: 'edit_user_path'
	delete 'user/del', to: 'users#destroy', as: 'delete_user_path'
	#post 'paintings/comments', to: 'comments#create'

	get 'user/:id/paintings', to: 'paintings#show_by_userid', as: 'show_paintings_by_user_id'

	get 'user/:id/feedbacks', to: 'feedbacks#index', as: 'index_feedbacks_path'
	post 'user/:id/feedbacks', to: 'feedbacks#create', as: 'create_feedback_path'
	get 'user/:id/feedbacks/:id', to: 'feedbacks#show', as: 'show_feedback_path'
	put 'user/:id/feedbacks/:id', to: 'feedbacks#update', as: 'edit_feedback_path'
	delete 'user/:id/feedbacks/:id', to: 'feedbacks#destroy', as: 'delete_feedback_path'
	resources :paintings do
			resources :comments
		end
	end
end
# >>>>>>> 67562002140f2e87d144fb21a70f46565ad5d4ab
