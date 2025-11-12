class EmitJson

    attr_accessor :CPF, :xNome, :xFant, :xLgr, :nro, :xCpl, :xBairro, :cMun, :CEP, :fone, :IE

    include ValidacoesGenericas

    def initialize(emit_json = {})
        campos = {
            'CPF' => { minimo: 1, maximo: 1, contagem: 0 },
            'xNome' => { minimo: 1, maximo: 1, contagem: 0 },
            'xFant' => { minimo: 0, maximo: 1, contagem: 0 },
            'xLgr' => { minimo: 1, maximo: 1, contagem: 0 },
            'nro' => { minimo: 1, maximo: 1, contagem: 0 },
            'xCpl' => { minimo: 0, maximo: 1, contagem: 0 },
            'xBairro' => { minimo: 1, maximo: 1, contagem: 0 },
            'cMun' => { minimo: 1, maximo: 1, contagem: 0 },
            'CEP' => { minimo: 1, maximo: 1, contagem: 0 },
            'fone' => { minimo: 0, maximo: 1, contagem: 0 },
            'IE' => { minimo: 1, maximo: 1, contagem: 0 }
        }
        validarCamposNaoEspecificados(emit_json, campos, 'nfae/emit')
        validarOcorrenciaDeCampos(emit_json, campos, 'nfae/emit')
        emit_json.each do |key, value|
            send("#{key}=", value) if respond_to?("#{key}=")
        end    
    end

    def CPF= value
        validarTamanhETipoDoCampo(11, 11, 'nfae/emit/CPF', value, 'N')
        @CPF = value
    end 
   
    def xNome= value
        validarTamanhETipoDoCampo(2, 60, 'nfae/emit/xNome', value, '*')
        @xNome = value
    end

    def xFant= value
        validarTamanhETipoDoCampo(1, 60, 'nfae/emit/xFant', value, '*')
        @xFant = value
    end

    def xLgr= value
        validarTamanhETipoDoCampo(2, 60, 'nfae/emit/xLgr', value, '*')
        @xLgr = value
    end

    def nro= value
        validarTamanhETipoDoCampo(1, 60, 'nfae/emit/nro', value, '*')
        @nro = value
    end

    def xCpl= value
        validarTamanhETipoDoCampo(1, 60, 'nfae/emit/xCpl', value, '*')
        @xCpl = value
    end

    def xBairro= value
        validarTamanhETipoDoCampo(1, 60, 'nfae/emit/xBairro', value, '*')
        @xBairro = value
    end

    def cMun= value
        validarTamanhETipoDoCampo(7, 7, 'nfae/emit/cMun', value, 'N')
        @cMun = value
    end

    def CEP= value
        validarTamanhETipoDoCampo(8, 8, 'nfae/emit/CEP', value, 'N')
        @CEP = value
    end

    def fone= value
        validarTamanhETipoDoCampo(6, 14, 'nfae/emit/fone', value, 'N')
        @fone = value
    end

    def IE= value
        validarTamanhETipoDoCampo(2, 14, 'nfae/emit/IE', value, 'C')
        @IE = value
    end

end