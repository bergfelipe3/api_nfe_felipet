class NfaeJson

    attr_accessor :ide, :emit, :dest, :prods, :transp, :pag, :infAdic

    include ValidacoesGenericas

    def initialize(nfae_json = {})
        nfae_json.each do |key, value|
            send("#{key}=", value) if respond_to?("#{key}=")
        end
    end

    def nfae= nfae_json
        campos = {
          'ide' => { minimo: 1, maximo: 1, contagem: 0 },
          'emit' => { minimo: 1, maximo: 1, contagem: 0 },
          'dest' => { minimo: 1, maximo: 1, contagem: 0 },
          'prods' => { minimo: 1, maximo: 1, contagem: 0 },
          'transp' => { minimo: 1, maximo: 1, contagem: 0 },
          'pag' => { minimo: 1, maximo: 1, contagem: 0 },
          'infAdic' => { minimo: 0, maximo: 1, contagem: 0 }
        }
        validarCamposNaoEspecificados(nfae_json, campos, 'nfae')
        validarOcorrenciaDeCampos(nfae_json, campos, 'nfae')
        nfae_json.each do |key, value|
          send("#{key}=", value) if respond_to?("#{key}=")
        end
    end

    def ide= ide_json
      @ide = IdeJson.new(ide_json)
    end

    def emit= emit_json
      @emit = EmitJson.new(emit_json)
    end

    def dest= dest_json
      @dest = DestJson.new(dest_json)
    end

    def prods= prods_json
      prods_array = []
      contagem = 0
      validarNumeroDeOcorreciasProd(prods_json)
      prods_json.each do |key, value|
        prods_array.push(ProdJson.new(key, contagem, @dest))
        contagem += 1
      end
      @prods = prods_array
    end

    def transp= transp_json
      @transp = TranspJson.new(transp_json)
    end

    def pag= pag_json
      @pag = PagJson.new(pag_json)
    end

    def infAdic= infAdic_json
      @infAdic = InfAdicJson.new(infAdic_json)
    end

    def validarNumeroDeOcorreciasProd(prods_json)
      if prods_json.length < 1 || prods_json.length > 990
        raise ExcecaoAplicacao::ExcecaoLayoutJSON, "Chave 'nfae/prods' não corresponde a ocorrência de itens máxima '990' e ocorrência mínimo '1' especificada no Layout JSON."
      end
    end

end