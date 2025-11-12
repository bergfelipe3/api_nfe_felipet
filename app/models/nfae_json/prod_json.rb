class ProdJson
    attr_accessor :cProd, :xProd, :NCM, :CFOP, :uCom, :qCom, :vUnCom, :uTrib, :qTrib, :vFrete, :vSeg, :vDesc, :vOutro, :CST, :pRedBC, :pICMS, :pICMSUFDest

    include ValidacoesGenericas

    def initialize(prods_json = {}, indice, dest)
        @indice = indice
        @dest = dest
        campos = {
            'cProd' => { minimo: 1, maximo: 1, contagem: 0 },
            'xProd' => { minimo: 1, maximo: 1, contagem: 0 },
            'NCM' => { minimo: 1, maximo: 1, contagem: 0 },
            'CFOP' => { minimo: 1, maximo: 1, contagem: 0 },
            'uCom' => { minimo: 1, maximo: 1, contagem: 0 },
            'qCom' => { minimo: 0, maximo: 1, contagem: 0 },
            'vUnCom' => { minimo: 1, maximo: 1, contagem: 0 },
            'uTrib' => { minimo: 1, maximo: 1, contagem: 0 },
            'qTrib' => { minimo: 1, maximo: 1, contagem: 0 },
            'vFrete' => { minimo: 0, maximo: 1, contagem: 0 },
            'vSeg' => { minimo: 0, maximo: 1, contagem: 0 },
            'vDesc' => { minimo: 0, maximo: 1, contagem: 0 },
            'vOutro' => { minimo: 0, maximo: 1, contagem: 0 },
            'CST' => { minimo: 1, maximo: 1, contagem: 0 },
            'pRedBC' => { minimo: 0, maximo: 1, contagem: 0 },
            'pICMS' => { minimo: 0, maximo: 1, contagem: 0 },
            'pICMSUFDest' => { minimo: 0, maximo: 1, contagem: 0 }
        }
        validarCamposNaoEspecificados(prods_json, campos, 'nfae/prods')
        validarOcorrenciaDeCampos(prods_json, campos, 'nfae/prods')
        prods_json.each do |key, value|
            send("#{key}=", value) if respond_to?("#{key}=")
        end
        validarObrigatoriedadeDePreenchimentoPICMS    
        validarObrigatoriedadeDePreenchimentoPRedBC
        validarObrigatoriedadeDePreenchimentoPICMSUFDest
    end

    def cProd= value
        validarTamanhETipoDoCampo(1, 60, "nfae/prods[#{@indice}]/cProd", value, 'C')
        @cProd = value
    end

    def xProd= value
        validarTamanhETipoDoCampo(1, 120, "nfae/prods[#{@indice}]/xProd", value, 'C')
        @xProd = value
    end
    
    def NCM= value
        tpNCMTamanhoLista = ['2','8']
        validarListaDoTamanhoDoValorDoCampoETipoDeDadoCampo(tpNCMTamanhoLista, "nfae/prods[#{@indice}]/NCM", value, 'N')
        @NCM = value
    end

    def CFOP= value
        validarTamanhETipoDoCampo(4, 4, "nfae/prods[#{@indice}]/CFOP", value, 'C')
        @CFOP = value
    end

    def uCom= value
        validarTamanhETipoDoCampo(1, 6, "nfae/prods[#{@indice}]/uCom", value, 'C')
        @uCom = value
    end

    def qCom= value
        validarTamanhoNumeroComDecimal(value, 1..11, 0..4, "nfae/prods[#{@indice}]/qCom")
        @qCom = value
    end

    def vUnCom= value
        validarTamanhoNumeroComDecimal(value, 1..11, 0..10, "nfae/prods[#{@indice}]/vUnCom")
        @vUnCom = value
    end

    def uTrib= value
        validarTamanhETipoDoCampo(1, 6, "nfae/prods[#{@indice}]/uTrib", value, 'C')
        @uTrib = value
    end

    def qTrib= value
        validarTamanhoNumeroComDecimal(value, 1..11, 0..4, "nfae/prods[#{@indice}]/qTrib")
        @qTrib = value
    end

    def vFrete= value
        validarTamanhoNumeroComDecimal(value, 1..13, 2..2, "nfae/prods[#{@indice}]/vFrete")
        @vFrete = value
    end

    def vSeg= value
        validarTamanhoNumeroComDecimal(value, 1..13, 2..2, "nfae/prods[#{@indice}]/vSeg")
        @vSeg = value
    end

    def vDesc= value
        validarTamanhoNumeroComDecimal(value, 1..13, 2..2, "nfae/prods[#{@indice}]/vDesc")
        @vDesc = value
    end

    def vOutro= value
        validarTamanhoNumeroComDecimal(value, 1..13, 2..2, "nfae/prods[#{@indice}]/vOutro")
        @vOutro = value
    end

    def CST= value
        cstLista = ['00','20', '41']
        validarListaDoValorDoCampo(cstLista, value, "nfae/prods[#{@indice}]/CST")
        @CST = value
    end

    def pRedBC= value
        validarTamanhoNumeroComDecimal(value, 1..3, 2..4, "nfae/prods[#{@indice}]/pRedBC")
        @pRedBC = value
    end

    def pICMS= value
        pICMSLista = ['4.0000' ,'7.0000', '12.0000']
        validarListaDoValorDoCampo(pICMSLista, value, "nfae/prods[#{@indice}]/pICMS")
        @pICMS = value
    end

    def pICMSUFDest= value
        validarTamanhoNumeroComDecimal(value, 1..3, 2..4, "nfae/prods[#{@indice}]/pICMSUFDest")
        numero_float = value.to_f
        if numero_float < 12 || numero_float > 36
            raise ExcecaoAplicacao::ExcecaoLayoutJSON, "Valor '#{value}' da chave 'nfae/prods[#{@indice}]/pICMSUFDest' fora do intervalo de 12 a 36 como especificado no Layout JSON."
        end
        @pICMSUFDest = value
    end

    def validarObrigatoriedadeDePreenchimentoPICMS
        if ['00', '20'].include?(@CST) && @pICMS.blank?
            raise ExcecaoAplicacao::ExcecaoLayoutJSON, "'nfae/prods[#{@indice}]/pICMS' obrigatório quando 'nfae/prods[#{@indice}]/CST' for igual a '20' ou '00' como especificado no Layout JSON."
        end
    end

    def validarObrigatoriedadeDePreenchimentoPICMSUFDest
        if @dest.indIEDest == '9' && @dest.cMun[0, 2] != '11'
            raise ExcecaoAplicacao::ExcecaoLayoutJSON, "'nfae/prods[#{@indice}]/pICMSUFDest' obrigatório quando 'nfae/dest/indIEDest' igual a '9' e UF do destinatário diferente de '11' como especificado no Layout JSON."
        end
    end

    def validarObrigatoriedadeDePreenchimentoPRedBC
        if @CST == '20' && @pRedBC.blank?
            raise ExcecaoAplicacao::ExcecaoLayoutJSON, "Chave 'nfae/prods[#{@indice}]/pRedBC' obrigatório quando 'nfae/prods[#{@indice}]/CST' for igual a '20' como especificado no Layout JSON."
        end
    end

end