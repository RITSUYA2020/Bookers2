Rails.application.routes.draw do
	devise_for :users, controllers: {sessions: 'devise/sessions',registrations: 'devise/registrations'}
	root 'homes#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  	resources :users

  	resources :books

  	get 'home/about' => 'users#new'

end
