Naturesoft::Slideshows::Engine.routes.draw do  
  namespace :backend, module: "backend" do
    resources :slides do
      collection do
        put ':id/enable' => 'slides#enable', :as => 'enable'
        put ':id/disable' => 'slides#disable', :as => 'disable'
        delete 'delete'
      end
    end
    resources :slideshows do
      collection do
        put ':id/enable' => 'slideshows#enable', :as => 'enable'
        put ':id/disable' => 'slideshows#disable', :as => 'disable'
        delete 'delete'
        get "select2"
      end
    end
  end
end
