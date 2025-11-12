module NfaeTiposBasicos
  class TiposBasicoV400

  #Classe do Tipo Código da UF da tabela do IBGE
  class TCodUfIBGE

    attr_accessor :cUF
   
    def initialize(cUF, nVar)
      @cUF = cUF
      cUF_lista = ['11','12','13','14','15','16','17','21','22','23','24','25','26','27','28','29','31','32','33','35','41','42','43','50','51','52','53']
      unless cUF_lista.include?cUF
        raise ExcecaoAplicacao::ExcecaoTipoBasico, "#{nVar};Código da Uf não listado"
      end
    end

  end

  #Classe do Tipo Código numérico que compõe a Chave de Acesso.
  class TCodNF

    attr_accessor :cNF
    
    def initialize(cNF, nVar)
      @cNF = cNF
      unless cNF.match(/^.{8}$/)
        raise ExcecaoAplicacao::ExcecaoTipoBasico, "#{nVar};Código númerico maior ou menor que oito dígitos"
      end     
      unless cNF.match(/^[0-9]*$/)
        raise ExcecaoAplicacao::ExcecaoTipoBasico, "#{nVar};Código númerico contém dado(s) não numérico(s)"
      end      
    end

  end

  #Classe do Tipo Modelo Documento Fiscal
  class TMod

    attr_accessor :mod

    def initialize(mod, nVar)
      @mod = mod 
      mod_lista = ['55', '65']
      unless mod_lista.include?mod
        raise ExcecaoAplicacao::ExcecaoTipoBasico, "#{nVar};Código do Modelo do Documento Fiscal não listado"
      end
    end

  end

  #Classe do Tipo Série do Documento Fiscal
  class TSerie

    attr_accessor :serie

    def initialize(serie, nVar)
      @serie = serie
      unless serie.match(/^[0-9]*$/)
        raise ExcecaoAplicacao::ExcecaoTipoBasico, "#{nVar};Série do Documento Fiscal contém dado(s) não numérico(s)"
      end
      unless serie.match(/^.{1,3}$/)
        raise ExcecaoAplicacao::ExcecaoTipoBasico, "#{nVar};Série do Documento Fiscal vazio ou maior que três dígitos"
      end    
    end

  end

  #Classe do Tipo Número do Documento Fiscal
  class TNF

    attr_accessor :nNF

    def initialize(nNF, nVar)
      @nNF = nNF
      unless nNF.match(/^[0-9]*$/)
        raise ExcecaoAplicacao::ExcecaoTipoBasico, "#{nVar};Número do Documento Fiscal contém dado(s) não numérico(s)"
      end
      unless nNF.match(/^.{1,9}$/)
        raise ExcecaoAplicacao::ExcecaoTipoBasico, "#{nVar};Número do Documento Fiscal vazio ou maior que nove dígitos"
      end      
    end

  end

  #Classe do Tipo Data e Hora, formato UTC (AAAA-MM-DDThh:mm:ssTZD, onde TZD = +hh:mm ou -hh:mm)
  class TDateTimeUTC

    attr_accessor :dtUTC

    def initialize(dtUTC, nVar)
      @dtUTC = dtUTC
      unless dtUTC.match(/^(((20(([02468][048])|([13579][26]))-02-29))|(20[0-9][0-9])-((((0[1-9])|(1[0-2]))-((0[1-9])|(1\d)|(2[0-8])))|((((0[13578])|(1[02]))-31)|(((0[1,3-9])|(1[0-2]))-(29|30)))))T(20|21|22|23|[0-1]\d):[0-5]\d:[0-5]\d([\-,\+](0[0-9]|10|11):00|([\+](12):00))$/)
        raise ExcecaoAplicacao::ExcecaoTipoBasico, "#{nVar};Data e Hora, formato UTC (AAAA-MM-DDThh:mm:ssTZD, onde TZD = +hh:mm ou -hh:mm) inválido"
      end  
    end

  end

  #Classe do Tipo do Documento Fiscal (0 - entrada; 1 - saída)
  class TTpNF

    attr_accessor :tpNF

    def initialize(tpNF, nVar)
      @tpNF = tpNF 
      tpNF_lista = ['0', '1']
      unless tpNF_lista.include?tpNF
        raise ExcecaoAplicacao::ExcecaoTipoBasico, "#{nVar};Tipo do Documento Fiscal não listado"
      end
    end

  end

  #Classe do Tipo Identificador de Local de destino da operação (1-Interna;2-Interestadual;3-Exterior)
  class TIdDest

    attr_accessor :idDest

    def initialize(idDest, nVar)
      @idDest = idDest 
      idDest_lista = ['1', '2', '3']
      unless idDest_lista.include?idDest
        raise ExcecaoAplicacao::ExcecaoTipoBasico, "#{nVar};Identificador de Local de destino da operação não listado"
      end
    end

  end

  #Classe Tipo Código do Município da tabela do IBGE
  class TCodMunIBGE

    attr_accessor :cMun

    def initialize(cMun, nVar)
      @cMun = cMun
      unless cMun.match(/^[0-9]*$/)
        raise ExcecaoAplicacao::ExcecaoTipoBasico, "#{nVar};Código do Município contém dado(s) não numérico(s)"
      end
      unless cMun.match(/^.{7}$/)
        raise ExcecaoAplicacao::ExcecaoTipoBasico, "#{nVar};Código do Município vazio ou maior que sete dígitos"
      end
    end

  end

  #Classe Tipo Formato de impressão do DANFE (0-sem DANFE;1-DANFe Retrato; 2-DANFe Paisagem;3-DANFe Simplificado;4-DANFe NFC-e;5-DANFe NFC-e em mensagem eletrônica)
  class TTpImp

    attr_accessor :tpImp

    def initialize(tpImp, nVar)
      @tpImp = tpImp 
      tpImp_lista = ['0', '1', '2', '3', '4', '5']
      unless tpImp_lista.include?tpImp
        raise ExcecaoAplicacao::ExcecaoTipoBasico, "#{nVar};Formato de impressão do DANFE não listado"
      end
    end

  end

  #Classe Tipo Forma de emissão da NF-e 1 - Normal; 2 - Contingência FS; 3 - Contingência SCAN; 4 - Contingência DPEC
  #5 - Contingência FSDA; 6 - Contingência SVC - AN; 7 - Contingência SVC - RS; 9 - Contingência off-line NFC-e
  class TTpEmis

    attr_accessor :tpEmis

    def initialize(tpEmis, nVar)
      @tpEmis = tpEmis 
      tpEmis_lista = ['1', '2', '3', '4', '5', '6', '7', '9']
      unless tpEmis_lista.include?tpEmis
        raise ExcecaoAplicacao::ExcecaoTipoBasico, "#{nVar};Forma de emissão da NF-e não listada"
      end
    end

  end

  #Classe Tipo Identificação do Ambiente: 1 - Produção 2 - Homologação
  class TTpAmb

    attr_accessor :tpAmb

    def initialize(tpAmb, nVar)
      @tpAmb = tpAmb 
      tpAmb_lista = ['1', '2']
      unless tpAmb_lista.include?tpAmb
        raise ExcecaoAplicacao::ExcecaoTipoBasico, "#{nVar};Ambiente não listado"
      end
    end

  end

  #Tipo Finalidade da NF-e (1=Normal; 2=Complementar; 3=Ajuste; 4=Devolução/Retorno)
  class TFinNFe

    attr_accessor :finNFe

    def initialize(finNFe, nVar)
      @finNFe = finNFe 
      finNFe_lista = ['1', '2', '3', '4']
      unless finNFe_lista.include?finNFe
        raise ExcecaoAplicacao::ExcecaoTipoBasico, "#{nVar};Finalidade da NF-e não listada"
      end
    end

  end

#Fim do Módulo
end
end