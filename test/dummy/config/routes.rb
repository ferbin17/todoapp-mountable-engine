Rails.application.routes.draw do
  mount Todoapp::Engine => "/todoapp"
end
