Harbinger::Engine.routes.draw do
  scope module: 'harbinger' do
    resources :messages, only: [:index, :show]
  end
end
