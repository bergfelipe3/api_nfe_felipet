class ConsultaController < ApplicationController
  def por_cpf
    cpf = params[:CPF_USUARIO].to_s.strip

    if cpf.blank?
      render json: { codigo: 400, mensagem: 'Informe o CPF do usuário na rota.' }, status: :bad_request
      return
    end

    notas = NfaAutorizada.where(CPF_USUARIO: cpf)

    if notas.exists?
      render json: { codigo: 200, mensagem: 'Notas encontradas.', notas: notas }, status: :ok
    else
      render json: { codigo: 404, mensagem: "Nenhuma nota encontrada para o CPF #{cpf}." }, status: :not_found
    end
  end
end
