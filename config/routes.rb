Rails.application.routes.draw do
  scope '/v1' do
    post '/emissao', to: 'emissao#obterMensagem', defaults: { format: :json }
    get '/teste', to: 'teste#obterMensagem', defaults: { format: :json }
    get '/consulta/:CPF_USUARIO', to: 'consulta#por_cpf', defaults: { format: :json }
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
