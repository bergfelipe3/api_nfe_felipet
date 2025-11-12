require 'base64'

class NfaAutorizada < ApplicationRecord
  self.table_name = "NFA_AUTORIZADA"

  def gravar_nfae(nfae_json, nfae_xml_resposta_autorizador, requisicao_http, enviNFe)
    xml_assinado = REXML::Document.new(enviNFe.to_xml)
    
    sql = <<-SQL
      INSERT INTO NFA_AUTORIZADA (
        chave, schema, ip, cpf_usuario, emit_id, nprot, dt_ini, dt_ws_autorizacao, 
        cstat_consulta, xmotivo_consulta, nnf, atividade, cstat_autorizar, 
        xmotivo_autorizar, dt_ws_consulta, xml_assinado_autorizacao, json_autorizacao, 
        dt_autorizacao, dt_fim, cancelada, serie, ie, idaron, gta
      ) VALUES (
        :chave, :schema, :ip, :cpf_usuario, :emit_id, :nprot, :dt_ini, :dt_ws_autorizacao, 
        :cstat_consulta, :xmotivo_consulta, :nnf, :atividade, :cstat_autorizar, 
        :xmotivo_autorizar, :dt_ws_consulta, :xml_assinado_autorizacao, :json_autorizacao, 
        :dt_autorizacao, :dt_fim, :cancelada, :serie, :ie, :idaron, :gta
      )
    SQL

    params = {
      chave: begin
        valor = nfae_xml_resposta_autorizador[:chNFe]
        valor.present? ? valor.force_encoding('UTF-8') : ""
      rescue
        ""
      end,
      schema: "nfe_v4.00".force_encoding('UTF-8'),
      ip: requisicao_http.ip.force_encoding('UTF-8'),
      cpf_usuario: nfae_json.ide.CPFUsuario.force_encoding('UTF-8'),
      emit_id: nfae_json.emit.CPF.force_encoding('UTF-8'),
      nprot: begin
        valor = nfae_xml_resposta_autorizador[:nProt]
        valor.present? ? valor.force_encoding('UTF-8') : ""
      rescue
        ""
      end,
      dt_ini: DateTime.current,
      dt_ws_autorizacao: safe_datetime(nfae_xml_resposta_autorizador[:dhRecbto]),
      cstat_consulta: safe_utf8(nfae_xml_resposta_autorizador[:cStat]),
      xmotivo_consulta: safe_utf8(nfae_xml_resposta_autorizador[:xMotivo]),
      nnf: xml_assinado.elements['//ide/nNF'].text.force_encoding('UTF-8'),
      atividade: "011".force_encoding('UTF-8'),
      cstat_autorizar: safe_utf8(nfae_xml_resposta_autorizador[:cStat]),
      xmotivo_autorizar: safe_utf8(nfae_xml_resposta_autorizador[:xMotivo]),
      dt_ws_consulta: DateTime.current,
      xml_assinado_autorizacao:  safe_base64_decode(nfae_xml_resposta_autorizador[:xmlAssinado]),
      json_autorizacao: nfae_json.to_json.force_encoding('UTF-8'),
      dt_autorizacao: DateTime.current,
      dt_fim: (DateTime.current + 1.day),
      cancelada: "N".force_encoding('UTF-8'),
      serie: "894",
      ie: xml_assinado.elements['//emit/IE'].text.force_encoding('UTF-8'),
      idaron: "S".force_encoding('UTF-8'),
      gta: nfae_json.ide.cGta.force_encoding('UTF-8')
    }

    connection = ActiveRecord::Base.connection

    if postgres_adapter?
      execute_postgres_insert(connection, params)
    else
      raw_connection = connection.raw_connection
      cursor = raw_connection.parse(sql)
      params.each { |key, value| cursor.bind_param(key, value) }
      cursor.exec
      cursor.close
    end
  end

  def buscar_e_verificar_nfa
    gta = params[:gta]
    
    # Busca a NFA pelo GTA
    nfa = NfaAutorizada.find_by(GTA: gta)
    
    if nfa.nil?
      render json: { codigo: 404, mensagem: "NFA não encontrada para o GTA fornecido: #{gta}" }, status: :not_found
      return
    end
  
    # Verifica o CSTAT_CONSULTA
    if nfa.CSTAT_CONSULTA != 100
      render json: { codigo: 404, mensagem: "Erro: CSTAT_CONSULTA inválido, valor: #{nfa.CSTAT_CONSULTA}" }, status: :not_found
      return
    end
  
    # Retorna a NFA caso esteja tudo certo
    render json: { codigo: 200, mensagem: "NFA encontrada e válida.", nfa: nfa }
  rescue ExcecaoAplicacao::ExcecaoLayoutJSON => e
    render json: { codigo: 400, mensagem: "#{e.message}" }, status: :bad_request
  rescue StandardError => e
    render json: { codigo: 500, mensagem: "Ocorreu um erro no servidor que impediu o processamento adequado da solicitação, #{e.message}" }, status: :internal_server_error
  end
  
  
  private

  def safe_utf8(value)
    value.present? ? value.to_s.force_encoding('UTF-8') : ""
  end

  def safe_datetime(value)
    value.present? ? DateTime.parse(value) : DateTime.current
  end

  def safe_base64_decode(value)
    decoded = value.present? ? Base64.decode64(value) : ""
    decoded.force_encoding('UTF-8')
  end

  def postgres_adapter?
    ActiveRecord::Base.connection.adapter_name.to_s.downcase.include?('postgresql')
  end

  def execute_postgres_insert(connection, params)
    values_with_timestamps = params.merge(
      created_at: DateTime.current,
      updated_at: DateTime.current
    )

    column_names = values_with_timestamps.keys.map do |key|
      column_name = timestamp_column?(key) ? key.to_s : key.to_s.upcase
      %("#{column_name}")
    end
    values = values_with_timestamps.keys.map { |key| connection.quote(values_with_timestamps[key]) }

    insert_sql = <<~SQL
      INSERT INTO "NFA_AUTORIZADA" (#{column_names.join(', ')})
      VALUES (#{values.join(', ')})
    SQL

    connection.execute(insert_sql)
  end

  def timestamp_column?(key)
    %i[created_at updated_at].include?(key)
  end


end
