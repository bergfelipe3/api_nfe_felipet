class TesteController < ApplicationController
  def obterMensagem
    p '33333333333333333333333333333333333333333333333333333333333333333333333333 oi'
     render json: {
        codigo: 200,
        mensagem: 'Requisição processada com sucesso 33333333333333333333333333333333333333333333333333333333333333333333333333 oi'
      }, status: :ok

   
  end
end