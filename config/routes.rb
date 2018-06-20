Rails.application.routes.draw do
  
  mount ForestLiana::Engine => '/forest'
namespace :v1 do

	post 'user/signin' => 'user_token#create'

	post 'user/signup', to: 'users#create', as: 'signup_path'
	get 'user/all', to: 'users#index', as: 'user_all_path'
	get 'user', to: 'users#show', as: 'show_user_path'
	put 'user/edit', to: 'users#update', as: 'edit_user_path'
	delete 'user/del', to: 'users#destroy', as: 'delete_user_path'
	put 'user/change_password', to: 'users#change_password', as: 'change_password_path'
	post 'password/forgot', to: 'passwords#forgot', as: 'forgot_password_path'
	post 'password/reset', to: 'passwords#reset', as: 'reset_password_path'
	get 'user/:id/paintings', to: 'paintings#show_by_userid', as: 'show_paintings_by_user_id'

	get 'user/:id/feedbacks', to: 'feedbacks#index', as: 'index_feedbacks_path'
	post 'user/feedbacks', to: 'feedbacks#create', as: 'create_feedback_path'
	get 'user/:id/feedbacks/:id', to: 'feedbacks#show', as: 'show_feedback_path'
	put 'user/:id/feedbacks/:id', to: 'feedbacks#update', as: 'edit_feedback_path'
	delete 'user/:id/feedbacks/:id', to: 'feedbacks#destroy', as: 'delete_feedback_path'
	resources :paintings do
			resources :comments
		end
	end
end
