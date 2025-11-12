class DestJson
    
    attr_accessor :CNPJ, :xNome, :xLgr, :nro, :xCpl, :xBairro, :cMun, :CEP, :fone, :indIEDest, :IE

    include ValidacoesGenericas

    def initialize(dest_json = {})
        campos = {
            'CNPJ' => { minimo: 1, maximo: 1, contagem: 0 },
            'xNome' => { minimo: 1, maximo: 1, contagem: 0 },
            'xLgr' => { minimo: 1, maximo: 1, contagem: 0 },
            'nro' => { minimo: 1, maximo: 1, contagem: 0 },
            'xCpl' => { minimo: 0, maximo: 1, contagem: 0 },
            'xBairro' => { minimo: 1, maximo: 1, contagem: 0 },
            'cMun' => { minimo: 1, maximo: 1, contagem: 0 },
            'CEP' => { minimo: 1, maximo: 1, contagem: 0 },
            'fone' => { minimo: 0, maximo: 1, contagem: 0 },
            'indIEDest' => { minimo: 1, maximo: 1, contagem: 0 },
            'IE' => { minimo: 0, maximo: 1, contagem: 0 }
        }
        validarCamposNaoEspecificados(dest_json, campos, 'nfae/dest')
        validarOcorrenciaDeCampos(dest_json, campos, 'nfae/dest')
        dest_json.each do |key, value|
            send("#{key}=", value) if respond_to?("#{key}=")
        end  
        validarObrigatoriedadeDePreenchimentoIE  
    end

    def CNPJ= value
        validarTamanhETipoDoCampo(14, 14, 'nfae/dest/CNPJ', value, 'N')
        @CNPJ = value
    end
    
    def xNome= value
        validarTamanhETipoDoCampo(2, 60, 'nfae/dest/xNome', value, '*')
        preencherXNome(value)
    end

    def xLgr= value
        validarTamanhETipoDoCampo(2, 60, 'nfae/dest/xLgr', value, '*')
        @xLgr = value
    end

    def nro= value
        validarTamanhETipoDoCampo(1, 60, 'nfae/dest/nro', value, '*')
        @nro = value
    end

    def xCpl= value
        validarTamanhETipoDoCampo(1, 60, 'nfae/dest/xCpl', value, '*')
        @xCpl = value
    end

    def xBairro= value
        validarTamanhETipoDoCampo(2, 60, 'nfae/dest/xBairro', value, '*')
        @xBairro = value
    end

    def cMun= value
        validarTamanhETipoDoCampo(7, 7, 'nfae/dest/cMun', value, 'N')
        @cMun = value
    end

    def CEP= value
        validarTamanhETipoDoCampo(8, 8, 'nfae/dest/CEP', value, 'N')
        @CEP = value
    end

    def fone= value
        validarTamanhETipoDoCampo(6, 14, 'nfae/dest/fone', value, 'N')
        @fone = value
    end

    def indIEDest= value
        indIEDestLista = ['1','9']
        validarListaDoValorDoCampo(indIEDestLista, value, 'nfae/dest/indIEDest')
        @indIEDest = value
    end

    def IE= value
        validarTamanhETipoDoCampo(2, 14, 'nfae/dest/IE', value, 'N')
        @IE = value
    end

    def validarObrigatoriedadeDePreenchimentoIE
        if @indIEDest == '1' && @IE.blank?
            raise ExcecaoAplicacao::ExcecaoLayoutJSON, "'nfae/dest/IE' obrigatório quando  'nfae/dest/indIEDest' for igual a '1' como especificado no Layout JSON."
        end
    end

    def preencherXNome value
       
        if DataRepository.instance.get(:tpAmb) == '2'
            @xNome = "NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL"
        else
            @xNome = value
        end
    end

end