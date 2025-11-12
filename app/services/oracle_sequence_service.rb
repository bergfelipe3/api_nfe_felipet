class OracleSequenceService
    def initialize(sequence_name)
      @sequence_name = sequence_name.to_s
    end
  
    def next_value
      if postgres_adapter?
        ActiveRecord::Base.connection.select_value("SELECT nextval('#{normalized_sequence_name}')")
      else
        ActiveRecord::Base.connection.select_value("SELECT #{@sequence_name}.NEXTVAL FROM dual")
      end
    end

    private

    def postgres_adapter?
      ActiveRecord::Base.connection.adapter_name.to_s.downcase.include?('postgresql')
    end

    def normalized_sequence_name
      @sequence_name.downcase
    end
end
