class FuncGeral
  
    def recuperar_data_hora_atual
      Time.now.utc.strftime("%Y-%m-%dT%H:%M:%S%:z")
    end
  
    def str_para_datetime(str_date_time)
      return nil if str_date_time.nil?
      DateTime.strptime(str_date_time, "%Y-%m-%dT%H:%M:%S")
    rescue ArgumentError
      nil
    end
  
    def remove_mascara(str)
      str.nil? ? "" : str.gsub(/\D/, "").strip
    end
  
    def tratar_virgula(str)
      str.gsub(".", "").gsub(",", ".").strip.to_f
    end
  
    def remover_acentos(str)
      return "" if str.nil?
      str.encode("ASCII", invalid: :replace, undef: :replace, replace: "")
    end
  
    def calcula_digito_verificador_ibge(codigo_municipio)
      return "" if codigo_municipio.nil? || codigo_municipio.empty?
  
      peso = [1, 2, 1, 2, 1, 2, 0]
      soma = 0
  
      codigo_municipio.chars.each_with_index do |char, i|
        valor = char.to_i * peso[i]
        soma += valor > 9 ? valor.digits.sum : valor
      end
  
      dv = (10 - (soma % 10)) % 10
      "#{codigo_municipio}#{dv}"
    end
  
    def formatar_data_xml(date_time)
      Date.parse(date_time.split("T")[0]).strftime("%d/%m/%Y")
    rescue ArgumentError
      nil
    end
  
    def self.recuperar_mes_ano(string)
      date = DateTime.parse(string) rescue nil
      date ? date.strftime("%m/%Y") : ""
    end
  
    def self.calcula_dt_vencimento(string)
      date = Date.parse(string) rescue nil
      date ? (date + 7).strftime("%d/%m/%Y") : ""
    end
  
    def self.formatar_valor_icms(valor)
      return "" if valor.nil? # Retorna string vazia se o valor for nil
      format("%.2f", valor.to_f).gsub(".", ",")
    end
  
    def formata_tamanho_string(str, tamanho)
      return "" if str.nil?
      str.length > tamanho ? str[0, tamanho - 1].strip : str.strip
    end
  
    def duas_casas_decimais(valor)
      format("%.2f", valor.to_f)
    end
  end
  