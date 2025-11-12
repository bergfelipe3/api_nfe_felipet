class TranspJson

    attr_accessor :modFrete, :transporta, :veicTransp, :vol

    include ValidacoesGenericas

    def initialize(transp_json = {})
        campos = {
            'modFrete' => { minimo: 1, maximo: 1, contagem: 0 },
            'transporta' => { minimo: 0, maximo: 1, contagem: 0 },
            'veicTransp' => { minimo: 0, maximo: 1, contagem: 0 },
            'vol' => { minimo: 0, maximo: 1, contagem: 0 }
        }
        validarCamposNaoEspecificados(transp_json, campos, 'nfae/transp')
        validarOcorrenciaDeCampos(transp_json, campos, 'nfae/transp')
        transp_json.each do |key, value|
            send("#{key}=", value) if respond_to?("#{key}=")
        end 
    end

    def modFrete= value
        modFreteLista = ['0','1', '2', '3', '4', '9']
        validarListaDoValorDoCampo(modFreteLista, value, 'nfae/transp/modFrete')
        @modFrete = value
    end
    
    def transporta= value
        @transporta = TransportaJson.new(value)
    end

    def veicTransp= value
        @veicTransp = VeicTranspJson.new(value)
    end

    def vol= value
        @vol = VolJson.new(value)
    end

end