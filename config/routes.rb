Naturesoft::Core::Engine.routes.draw do  
  scope module: 'slideshows' do
    namespace :admin, module: "admin" do
      resources :slides
      resources :slideshows
    end
  end
end