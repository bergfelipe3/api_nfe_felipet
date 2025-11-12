class PagJson
    attr_accessor :tPag, :vPag, :xPag

    include ValidacoesGenericas

    def initialize(pag_json = {})
        campos = {
            'tPag' => { minimo: 1, maximo: 1, contagem: 0 }
        }
        validarCamposNaoEspecificados(pag_json, campos, 'nfae/pag')
        validarOcorrenciaDeCampos(pag_json, campos, 'nfae/pag')
        pag_json.each do |key, value|
            send("#{key}=", value) if respond_to?("#{key}=")
        end 
        
    end

    def tPag= value
        tPagLista = ['01','02', '03', '04', '05', '06', '07', '08', '09', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '90', '99']
        validarListaDoValorDoCampo(tPagLista, value, 'nfae/pag/tPag')
        @tPag = value
    end

    def vPag= value
        validarTamanhoNumeroComDecimal(value, 1..13, 2..2, "nfae/pag/vPag")
        @vPag = value
    end

    def xPag= value
        validarTamanhETipoDoCampo(2, 60, "nfae/pag/xPag", value, 'C')
        @xPag = value
    end

    def preencherVPag
        if @tPag == '90'
            @vPag = '0.00'
        end
    end

    def validarObrigatoriedadeDePreenchimentoVPag
        if  @tPag != '90' && @vPag.blank?
            raise ExcecaoAplicacao::ExcecaoLayoutJSON, "'nfae/pag/vPag' obrigatório quando 'nfae/pag/tPag' for diferente de '90' como especificado no Layout JSON."
        end
    end

    def validarObrigatoriedadeDePreenchimentoXPag
        if  @tPag == '99' && @xPag.blank?
            raise ExcecaoAplicacao::ExcecaoLayoutJSON, "'nfae/pag/xPag' obrigatório quando 'nfae/pag/tPag' for igual a '99' como especificado no Layout JSON."
        end
    end

end