Naturesoft::Slideshows::Engine.routes.draw do  
  namespace :admin, module: "admin" do
    resources :slides
    resources :slideshows
  end
end
