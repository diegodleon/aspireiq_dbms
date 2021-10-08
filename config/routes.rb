Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'generate_update_statement', to: 'statement_generators#generate_update_statement'
end
