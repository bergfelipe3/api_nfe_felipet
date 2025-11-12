class VolJson

    attr_accessor :qVol, :esp, :marca, :nVol, :pesoL, :pesoB
    
    include ValidacoesGenericas

    def initialize(vol_json = {})
        campos = {
            'qVol' => { minimo: 0, maximo: 1, contagem: 0 },
            'esp' => { minimo: 0, maximo: 1, contagem: 0 },
            'marca' => { minimo: 0, maximo: 1, contagem: 0 },
            'nVol' => { minimo: 0, maximo: 1, contagem: 0 },
            'pesoL' => { minimo: 0, maximo: 1, contagem: 0 },
            'pesoB' => { minimo: 0, maximo: 1, contagem: 0 }
        }
        validarCamposNaoEspecificados(vol_json, campos, 'nfae/transp/vol')
        validarOcorrenciaDeCampos(vol_json, campos, 'nfae/transp/vol')
        vol_json.each do |key, value|
            send("#{key}=", value) if respond_to?("#{key}=")
        end 
    end

    def qVol= value
        validarTamanhETipoDoCampo(1, 15, "nfae/transp/vol/qVol", value, 'N')
        @qVol = value
    end

    def esp= value
        validarTamanhETipoDoCampo(1, 60, "nfae/transp/vol/esp", value, 'C')
        @esp = value
    end

    def marca= value
        validarTamanhETipoDoCampo(1, 60, "nfae/transp/vol/marca", value, 'C')
        @marca = value
    end

    def nVol= value
        validarTamanhETipoDoCampo(1, 60, "nfae/transp/vol/nVol", value, 'C')
        @nVol = value
    end

    def pesoL= value
        validarTamanhoNumeroComDecimal(value, 1..12, 3..3, "nfae/transp/vol/pesoL")
        @pesoL = value
    end

    def pesoB= value
        validarTamanhoNumeroComDecimal(value, 1..12, 3..3, "nfae/transp/vol/pesoB")
        @pesoB = value
    end

end