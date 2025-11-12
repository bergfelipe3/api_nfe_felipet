class VeicTranspJson

    attr_accessor :placa, :UF, :RNTC

    include ValidacoesGenericas

    def initialize(veictransp_json = {})
        campos = {
            'placa' => { minimo: 1, maximo: 1, contagem: 0 },
            'UF' => { minimo: 1, maximo: 1, contagem: 0 },
            'RNTC' => { minimo: 0, maximo: 1, contagem: 0 }
        }
        validarCamposNaoEspecificados(veictransp_json, campos, 'nfae/transp/veicTransp')
        validarOcorrenciaDeCampos(veictransp_json, campos, 'nfae/transp/veicTransp')
        veictransp_json.each do |key, value|
            send("#{key}=", value) if respond_to?("#{key}=")
        end 
    end

    def placa= value
        validarTamanhETipoDoCampo(7, 7, "nfae/transp/veicTransp/placa", value, 'C')
        @CNPJ = value
    end

    def UF= value
        validarListaDoValorDoCampo(obterListaSiglaUf, value, "nfae/transp/veicTransp/UF")
        @CNPJ = value
    end

    def RNTC= value
        validarTamanhETipoDoCampo(1, 20, "nfae/transp/veicTransp/RNTC", value, 'C')
        @CNPJ = value
    end

end