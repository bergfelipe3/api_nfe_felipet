class EmissaoController < ApplicationController

    def obterMensagem
        begin
            payload = parse_payload(request.body.read)

            @nfae = construir_nota(payload['nota'])
            enviNFe = EnviNfeXml.new(@nfae)

            certificado_service = CertificadoService.new(
                certificado_id: payload['certificado_id'],
                pfx_base64: payload['pfx_base64'],
                senha_certificado: payload['senha_certificado']
            )
            pkcs12 = certificado_service.pkcs12

            param_env = 2
            xml_canonical = AssinadorXml.new(pkcs12: pkcs12).assinar(Nokogiri::XML(enviNFe.to_xml)).root.canonicalize.to_s

            @retorno_autorizador = Autorizador.new(pkcs12: pkcs12).autorizar(xml_canonical, param_env)
            NfaAutorizada.new.gravar_nfae(@nfae,  @retorno_autorizador, request, enviNFe)

            resposta = construir_resposta(@retorno_autorizador)

            if @retorno_autorizador[:cStat] == '100'
                render json: resposta.merge(codigo: 200, mensagem: 'Requisição processada com sucesso'), status: :ok
            else
                render json: resposta.merge(codigo: 400, mensagem: 'Requisição processada com sucesso, porém houve erro na autorização'), status: :bad_request
            end
        rescue CertificadoService::CertificadoInvalidoError => e
            render json: { codigo: 400, mensagem: e.message }, status: :bad_request
        rescue JSON::ParserError => e
            render json: { codigo: 400, mensagem: "Ocorreu um erro ao analisar o JSON: Confira se as chaves de aberturas e fechamentos, chaves e valores estão corretos." }, status: :bad_request
        rescue ExcecaoAplicacao::ExcecaoLayoutJSON => e
            render json: { codigo: 400, mensagem: "#{e.message}" }, status: :bad_request
        rescue StandardError => e
            Rails.logger.error("[EmissaoController] #{e.class}: #{e.message}")
            Rails.logger.error(e.backtrace.join("\n")) if e.backtrace.present?
            render json: { codigo: 500, mensagem: "Ocorreu um erro no servidor que impediu o processamento adequado da solicitação, #{e.message}" }, status: :internal_server_error
        end
    end

    private

    def parse_payload(raw_body)
        JSON.parse(raw_body.presence || '{}')
    end

    def construir_nota(nota_hash)
        if nota_hash.blank?
            raise ExcecaoAplicacao::ExcecaoLayoutJSON, "Informe a chave 'nota' com os dados completos da NF-e."
        end

        nfae = NfaeJson.new
        nfae.nfae = nota_hash
        nfae
    end

    def construir_resposta(retorno_autorizador)
        status_nfe = retorno_autorizador[:cStat] == '100' ? 'autorizado' : 'erro'

        {
            status: status_nfe,
            cstat: retorno_autorizador[:cStat],
            xmotivo: retorno_autorizador[:xMotivo],
            protocolo: retorno_autorizador[:nProt],
            xml_assinado: retorno_autorizador[:xmlAssinado]
        }
    end

end
