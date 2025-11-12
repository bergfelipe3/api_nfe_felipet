class TransportaJson

    attr_accessor :CNPJ, :CPF, :xNome, :IE, :xEnder, :xMun, :UF

    include ValidacoesGenericas

    def initialize(transporte_json = {})
        campos = {
            'CNPJ' => { minimo: 0, maximo: 1, contagem: 0 },
            'CPF' => { minimo: 0, maximo: 1, contagem: 0 },
            'xNome' => { minimo: 0, maximo: 1, contagem: 0 },
            'IE' => { minimo: 0, maximo: 1, contagem: 0 },
            'xEnder' => { minimo: 0, maximo: 1, contagem: 0 },
            'xMun' => { minimo: 0, maximo: 1, contagem: 0 },
            'UF' => { minimo: 0, maximo: 1, contagem: 0 }
        }
        validarCamposNaoEspecificados(transporte_json, campos, 'nfae/transp/transporta')
        validarOcorrenciaDeCampos(transporte_json, campos, 'nfae/transp/transporta')
        validarCamposExclusivos(campos)
        validarObrigatoriedadeDePreenchimentoUF(campos)
        transporte_json.each do |key, value|
            send("#{key}=", value) if respond_to?("#{key}=")
        end 
    end

    def CNPJ= value
        validarTamanhETipoDoCampo(14, 14, "nfae/transp/transporta/CNPJ", value, 'N')
        @CNPJ = value
    end
    
    def CPF= value
        validarTamanhETipoDoCampo(11, 11, "nfae/transp/transporta/CPF", value, 'N')
        @CPF = value
    end

    def xNome= value
        validarTamanhETipoDoCampo(2, 60, "nfae/transp/transporta/xNome", value, 'C')
        @xNome = value
    end

    def IE= value
        validarCamposIEIsento(value)
        validarTamanhETipoDoCampo(2, 14, "nfae/transp/transporta/IE", value, 'C')
        @IE = value
    end

    def xEnder= value
        validarTamanhETipoDoCampo(1, 60, "nfae/transp/transporta/xEnder", value, 'C')
        @xEnder = value
    end

    def xMun= value
        validarTamanhETipoDoCampo(1, 60, "nfae/transp/transporta/xMun", value, 'C')
        @xMun = value
    end

    def UF= value
        validarListaDoValorDoCampo(obterListaSiglaUf, value, "nfae/transp/transporta/UF")
        @UF = value
    end

    def validarObrigatoriedadeDePreenchimentoUF(campos)
        if campos['IE'][:contagem] > 0 && campos['UF'][:contagem] == 0
            raise ExcecaoAplicacao::ExcecaoLayoutJSON, "'nfae/transp/transporta/UF' obrigatório quando 'nfae/transp/transporta/IE' for preenchido como especificado no Layout JSON."
        end
    end

    def validarCamposExclusivos(campos)
        if campos['CNPJ'][:contagem] > 0 && campos['CPF'][:contagem] > 0
            raise ExcecaoAplicacao::ExcecaoLayoutJSON, "CPF 'nfae/transp/transporta/CPF' e CNPJ 'nfae/transp/transporta/CNPJ' são exclusivas não podendo se preechidas juntas no mesmo documento como especificado no Layout JSON."
        end
    end

    def validarCamposIEIsento(value)
        p "Validando IE Isento #{value} #{@IE !~ /\A\d+\z/} #{value.to_s.upcase != "ISENTO"}"
        if value !~ /\A\d+\z/ && value.to_s.upcase != "ISENTO"
            raise ExcecaoAplicacao::ExcecaoLayoutJSON, "IE 'nfae/transp/transporta/IE' deve conter apenas números ou o valor 'ISENTO', como especificado no Layout JSON. O valor enviado foi '#{value}'."
        end
    end

end