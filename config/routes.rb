Harbinger::Engine.routes.draw do
  scope module: 'harbinger' do
    resources :messages, only: [:index, :show]
    root 'messages#index'
  end
end
