module ValidacoesGenericas
  
    def obterListaSiglaUf
      uFLista = ['AC','AL', 'AM', 'AP', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MG', 'MS', 'MT', 'PA', 'PB', 'PE', 'PI', 'PR', 'RJ', 'RN', 'RO', 'RR', 'RS', 'SC', 'SE', 'SP', 'TO', 'EX']
    end

    def remover_espaco_branco_ini_fim_campos
      attributes.each do |attr, value|
        self[attr].strip! if value.is_a?(String)
      end
    end

    def validarCamposNaoEspecificados(json, campos, pai)
      campos_esperados = campos.keys
      if json.is_a?(Hash)
        json.each do |key, value|
            if !campos_esperados.include?(key)
                raise ExcecaoAplicacao::ExcecaoLayoutJSON, "Chave '#{pai}/#{key}' não especificada no Layout JSON."
            end
        end
      else
        raise ExcecaoAplicacao::ExcecaoLayoutJSON, "O valor '#{json}' da chave '#{pai}' não é do tipo objeto como especificada no Layout JSON."
      end
    end

    def validarOcorrenciaDeCampos(nfae_json, campos, pai)
      nfae_json.each do |key, _|
        if campos.key?(key)
          campos[key][:contagem] += 1
        end
      end
      campos.each do |campo, limites|
        if limites[:minimo] == 1 && limites[:contagem] == 0
          raise ExcecaoAplicacao::ExcecaoLayoutJSON, "Chave '#{pai}/#{campo}' obrigatório na especificação do Layout JSON."
        end
        if limites[:contagem] > limites[:maximo]
          raise ExcecaoAplicacao::ExcecaoLayoutJSON, "Chave '#{pai}/#{campo}' com mais de '#{limites[:maximo]}' ocorrência(s) que especificado no Layout JSON."
        end
        if limites[:contagem] < limites[:minimo]
          raise ExcecaoAplicacao::ExcecaoLayoutJSON, "Chave '#{pai}/#{campo}' com menos de '#{limites[:minimo]}' ocorrência(s) que especificado no Layout JSON."
        end
      end    
    end  
    
    def validarListaDoValorDoCampo(lista = [], value, nome_chave)
        unless lista.include?value
            raise ExcecaoAplicacao::ExcecaoLayoutJSON, "Valor '#{value}' da chave '#{nome_chave}' não atende a especificação do Layout JSON. Valores permitidos #{lista.to_s.gsub('"', '')}."
        end
    end

    def validarListaDoTamanhoDoValorDoCampo(lista = [], value, nome_chave)
      unless lista.include?value.length.to_s
          raise ExcecaoAplicacao::ExcecaoLayoutJSON, "O tamanho '#{value.length}' do valor '#{value}' da chave '#{nome_chave}' não atende a especificação do Layout JSON Tamanhos permitidos #{lista.to_s.gsub('"', '')}."
      end
    end

    def validarTamanhoEmIntervaloDoValorDoCampo(tamanho_minimo, tamanho_maximo, nome_chave, value)
      unless value.match(/^.{#{tamanho_minimo},#{tamanho_maximo}}$/)
        raise ExcecaoAplicacao::ExcecaoLayoutJSON, "Valor '#{value}' de tamanho '#{value.to_s.length}' da chave '#{nome_chave}' não corresponde o tamanho máximo '#{tamanho_maximo}' e o tamanho mínimo '#{tamanho_minimo}' especificado no Layout JSON."
      end
    end

    def validarTipoDeDadoCampo(value, nome_chave, tipo_dado)
      case tipo_dado
      when '*'
        # Aceita qualquer caractere (inclusive símbolos, emojis, etc.)
        unless value.match(/.*/m)
          raise ExcecaoAplicacao::ExcecaoLayoutJSON,
            "Valor '#{value}' da chave '#{nome_chave}' não é válido. Qualquer caractere é permitido conforme especificado no Layout JSON."
        end
      when 'C2'
        # Verifica se é alfanumérico com ponto e vírgula
        unless value.match(/^[\p{L}\p{N}\s,.\-;]*$/)
          raise ExcecaoAplicacao::ExcecaoLayoutJSON,
                "Valor '#{value}' da chave '#{nome_chave}' não é válido. Apenas caracteres alfanuméricos, espaços, vírgulas, pontos, ponto e vírgula e traços são permitidos conforme especificado no Layout JSON."
        end
      when 'C'
        # Verifica se é alfanumérico
        unless value.match(/^[\p{L}\p{N}\s,-]*$/)
          raise ExcecaoAplicacao::ExcecaoLayoutJSON, 
                "Valor '#{value}' da chave '#{nome_chave}' não é válido. Apenas caracteres alfanuméricos, espaços, vírgulas e traços são permitidos conforme especificado no Layout JSON."
        end        
      when 'N'
        # Verifica se é um número
        unless value.match(/^[0-9]+$/)
          raise ExcecaoAplicacao::ExcecaoLayoutJSON, "Valor '#{value}' da chave '#{nome_chave}' não é Número como especificado no Layout JSON."
        end
      when 'D'
        # Verifica se é uma data no formato AAAA-MM-DD
        unless value.match(/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/)
          raise ExcecaoAplicacao::ExcecaoLayoutJSON, "Valor '#{value}' da chave '#{nome_chave}' não é no formato AAAA-MM-DD como especificado no Layout JSON."
        end
        begin
          Date.strptime(value, '%Y-%m-%d')
        rescue ArgumentError
          raise ExcecaoAplicacao::ExcecaoLayoutJSON, "Valor '#{value}' da chave '#{nome_chave}' não é uma data válida no formato AAAA-MM-DD como especificado no Layout JSON."
        end
      when 'DH'
        # Verifica se é uma data e hora no formato UTC (AAAA-MM-DDThh:mm:ssTZD)
        begin
          DateTime.iso8601(value)
        rescue ArgumentError
          raise ExcecaoAplicacao::ExcecaoLayoutJSON, "Valor '#{value}' da chave '#{nome_chave}' não é no formato UTC (Universal Coordinated Time): AAAA-MM-DDThh:mm:ssTZD como especificado no Layout JSON."
        end
      when 'B64'
        unless !value.empty? && !!(value =~ /\A[A-Za-z0-9+\/=]+\z/)
          raise ExcecaoAplicacao::ExcecaoLayoutJSON, "Valor '#{value}' da chave '#{nome_chave}' não é no formato Base64 como especificado no Layout JSON."
        end
      else
        raise ExcecaoAplicacao::ExcecaoLayoutJSON, "Valor '#{value}' da chave '#{nome_chave}' não é um formato reconhecido."
      end
    end

    def validarTamanhoNumeroComDecimal(value, intervalo_inteiro, intervalo_decimal, nome_chave)
      regex = /^\d+(\.\d+)?$/
      if !regex.match?(value)
        raise ExcecaoAplicacao::ExcecaoLayoutJSON, "Valor '#{value}' da chave '#{nome_chave}' não é um número válido como especificado no Layout JSON."
      end
      partes = value.to_s.split('.')
      parte_inteira = partes[0]
      parte_decimal = partes[1] || ""
      if !(intervalo_inteiro.include?(parte_inteira.length))
        raise ExcecaoAplicacao::ExcecaoLayoutJSON, " Valor '#{value}' a parte inteira '#{parte_inteira}' de tamanho '#{parte_inteira.to_s.length}' da chave '#{nome_chave}' não corresponde o tamanho máximo '#{intervalo_inteiro.end}' e o tamanho mínimo '#{intervalo_inteiro.begin}' especificado no Layout JSON."
      end
      if !(intervalo_decimal.include?(parte_decimal.length))
        raise ExcecaoAplicacao::ExcecaoLayoutJSON, " Valor '#{value}' a parte decimal '#{parte_decimal}' de tamanho '#{parte_decimal.to_s.length}' da chave '#{nome_chave}' não corresponde o tamanho máximo '#{intervalo_decimal.end}' e o tamanho mínimo '#{intervalo_decimal.begin}' especificado no Layout JSON."
      end
    end
    
    def validarTamanhETipoDoCampo(tamanho_minimo, tamanho_maximo, nome_chave, value, tipo_dado)
      validarTamanhoEmIntervaloDoValorDoCampo(tamanho_minimo,tamanho_maximo, nome_chave, value)
      validarTipoDeDadoCampo(value, nome_chave ,tipo_dado)
    end

    def validarListaDoTamanhoDoValorDoCampoETipoDeDadoCampo(lista = [], nome_chave, value, tipo_dado)
      validarListaDoTamanhoDoValorDoCampo(lista, value, nome_chave)
      validarTipoDeDadoCampo(value, nome_chave, tipo_dado)
    end
    
end