Naturesoft::Slideshows::Engine.routes.draw do  
  namespace :admin, module: "admin" do
    resources :slides do
      collection do
        put ':id/enable' => 'slides#enable', :as => 'enable'
        put ':id/disable' => 'slides#disable', :as => 'disable'
      end
    end
    resources :slideshows
  end
end
