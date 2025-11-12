require 'builder'

class InfNfeXml
    
    attr_accessor   :Id, :versao, :ide, :emit, :serie, :nNF, :cNF, :avulsa, :cDV, :dest, :det, :total, :transp, :pag, :infAdic, :nfae, :vNF

    def initialize(nfae)
        @cUF = "11" 
        @aamm = gerar_aamm  
        @cnpjEmitente = "05599253000147" 
        @mod = "55" 
        @serie = "899" 
        @nNF = gerar_nNF
        @tpEmis = "1"
        @cNF = gerar_cNF
        @chave_sem_digito = gerar_chave_sem_digito
        @cDV = gerar_cDV
        @Id = gerar_id
        @versao = "4.00"
        @nfae = nfae
        @vNF = '0.00'
    end

    def gerar_aamm
        Time.now.strftime("%y%m")
    end

    def gerar_nNF
        service = OracleSequenceService.new("SQ_NNF_894")
        next_value = service.next_value
        next_value.to_s.rjust(9, '0') 
    end
      

    def gerar_cNF
        codigo = Array.new(8) { rand(10) }.join
        codigo
    end

    def gerar_chave_sem_digito
        @cUF.to_s + @aamm.to_s + @cnpjEmitente.to_s + @mod.to_s + @serie.to_s + @nNF.to_s + @tpEmis.to_s + @cNF.to_s
    end
    
    def gerar_cDV()
        if @chave_sem_digito.length != 43
            raise ArgumentError.new("Chave Invalida possui #{@chave_sem_digito.length}")
        end
        aux = Array.new(@chave_sem_digito.length)
        variavel = 2
        total = 0
        (@chave_sem_digito.length - 1).downto(0) do |i|
          aux[i] = @chave_sem_digito[i].to_i
          aux[i] *= variavel
          variavel += 1
          variavel = 2 if variavel > 9
          total += aux[i]
        end
        total %= 11
        dv = if total == 0 || total == 1
               0
             else
               11 - total
             end

        dv.to_s
    end

    def gerar_id
        "NFe" +  @chave_sem_digito + @cDV 
    end

    def to_xml(nFe)
        nFe.infNFe(versao: @versao, Id: @Id) do |infNFe|
            @ide = IdeXml.new(@nfae, self).to_xml(infNFe)
            @emit = EmitXml.new(@nfae, self).to_xml(infNFe)
            @avulsa = AvulsaXml.new(@nfae, self).to_xml(infNFe)
            @dest = DestXml.new(@nfae, self).to_xml(infNFe)
            @nfae.prods.each_with_index do | det, index |
               @det = DetXml.new(@nfae, self, index + 1).to_xml(infNFe)
            end
            @total = TotalXml.new(@nfae, self, @det).to_xml(infNFe)
            @transp = TranspXml.new(@nfae, self).to_xml(infNFe)
            @pag = PagXml.new(@nfae, self).to_xml(infNFe)
            @infAdic = InfAdicXml.new(@nfae, self).to_xml(infNFe)
        end
      end
      


end