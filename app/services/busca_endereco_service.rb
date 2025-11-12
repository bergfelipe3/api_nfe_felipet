class BuscaEnderecoService
    def service(cMun)
      municipio = Municipio.find_by(cmundv: cMun)

      if municipio
        @sequence_name = municipio.nome
      else
        # Ou levanta uma exceção customizada, ou retorna uma mensagem:
        raise ExcecaoAplicacao::ExcecaoLayoutJSON, "Município com código #{cMun} não encontrado."
      end
    end
  
    def cuf(cMun)

      municipio = Municipio.find_by(cmundv: cMun)
    
      unless municipio
         raise ExcecaoAplicacao::ExcecaoLayoutJSON, "Município com código #{cMun} não encontrado."
      end


      estado = Estado.find_by(cuf: municipio.cuf)

      unless estado
        raise ExcecaoAplicacao::ExcecaoLayoutJSON, "Estado com código #{municipio.cuf} não encontrado para o município #{municipio.nome}."
      end
  
      @codigo_uf = estado.sigla

    end

    # Método para obter o valor de @codigo_uf
    def obter_codigo_uf
      @codigo_uf
    end
  end
  