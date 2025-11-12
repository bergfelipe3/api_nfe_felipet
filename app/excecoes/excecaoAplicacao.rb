#Módulo com as classes de exceções personalizadas da aplicação
module ExcecaoAplicacao

    #Exceção de dados Tipo básico da NFe
    class ExcecaoTipoBasico < StandardError

      def initialize(msg="Tipo Básico não aceito")
        super(msg)
      end

    end  

    #Exceção de Layout JSON
    class ExcecaoLayoutJSON < StandardError

      def initialize(msg="Falha no layout")
        super("Erro no Layout JSON da requisição, #{msg}")
      end

    end 

end