class InfAdicJson

    attr_accessor :infCpl

    include ValidacoesGenericas

    def initialize(infAdic_json = {})
        campos = {
            'infCpl' => { minimo: 1, maximo: 1, contagem: 0 }
        }
        validarCamposNaoEspecificados(infAdic_json, campos, 'nfae/infAdic')
        validarOcorrenciaDeCampos(infAdic_json, campos, 'nfae/infAdic')
        infAdic_json.each do |key, value|
            send("#{key}=", value) if respond_to?("#{key}=")
        end 
    end

    def infCpl= value
        validarTamanhETipoDoCampo(1, 5000, "nfae/infAdic/infCpl", value, '*')
        @infCpl = value
    end
    
end