ControllerCallbakStoreInSession::Application.routes.draw do
  get 'example' => 'example#index'
  post 'increase' => 'example#increase'
  post 'reset' => 'example#reset'

  root to: 'example#index'
end
