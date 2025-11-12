class Sitafe::SitafeHistoricoContribuinte < ApplicationRecord
	
	has_many :sitafe_hist_contr_ativ_secund, foreign_key: 'tuk', primary_key: 'tuk', dependent: :delete_all
	
	self.table_name = 'SITAFE.SITAFE_HISTORICO_CONTRIBUINTE'
	self.sequence_name = 'SITAFE.SEQ_SITAFE_HISTORICO_CONTRIBUI'
	self.primary_key = 'tuk'
	
	
	self.attribute('it_in_ultima_fac', :integer)
	
	validates_uniqueness_of :sp_insc_data_hora, allow_nil: true
	
	after_find do |sitafe_historico_contribuinte|
    sitafe_historico_contribuinte.attribute_names.each do |name|
      self.class.send(:define_method, "#{name}") do
        if !read_attribute(:"#{name}").nil? && read_attribute(:"#{name}").class == String
          read_attribute(:"#{name}").encode('UTF-8', 'Windows-1252', invalid: :replace, undef: :replace, replace: '?')
        else
          read_attribute(:"#{name}")
        end
      end
    end
  end

  before_save do |sitafe_historico_contribuinte|
    supers
  end

	private

	def fields_empty?(fields)
		fields.each do |field|
			return true if field.to_s == nil || field.to_s.strip == ''
		end

		return false
	end
	
	def supers
		
		if fields_empty? [self.it_co_atividade_economica, self.it_nu_inscricao_estadual, self.it_in_ultima_fac]
			self.sp_atividade_inscricao_ultima = nil
		else
			self.sp_atividade_inscricao_ultima = "#{self.it_co_atividade_economica.to_s[0..6].ljust(7)}#{self.it_nu_inscricao_estadual.to_s[0..13].ljust(14)}#{self.it_in_ultima_fac.to_s[0..0]}"
		end

		if fields_empty? [self.it_in_conder, self.it_nu_inscricao_estadual]
			self.sp_conder_insc = nil
		else
			self.sp_conder_insc = "#{self.it_in_conder.to_s[0..0].ljust(1)}#{self.it_nu_inscricao_estadual.to_s[0..13]}"
		end

		if fields_empty? [self.gr_ident_contador, self.it_nu_inscricao_estadual, self.it_in_ultima_fac]
			self.sp_contador_insc_ultimo = nil
		else
			self.sp_contador_insc_ultimo = "#{self.gr_ident_contador.to_s[0..14].ljust(15)}#{self.it_nu_inscricao_estadual.to_s[0..13].ljust(14)}#{self.it_in_ultima_fac.to_s[0..0]}"
		end

		if fields_empty? [self.it_da_referencia, self.it_in_ultima_fac]
			self.sp_data_referencia_ultima = nil
		else
			self.sp_data_referencia_ultima = "#{self.it_da_referencia.to_s[0..7].ljust(8)}#{self.it_in_ultima_fac.to_s[0..0]}"
		end

		if fields_empty? [self.gr_identificacao, self.it_in_ultima_fac]
			self.sp_identificacao_ultima = nil
		else
			self.sp_identificacao_ultima = "#{self.gr_identificacao.to_s[0..14].ljust(15)}#{self.it_in_ultima_fac.to_s[0..0]}"
		end

		if fields_empty? [self.it_nu_inscricao_estadual, self.it_in_ultima_fac]
			self.sp_inscricao_ultima = nil
		else
			self.sp_inscricao_ultima = "#{self.it_nu_inscricao_estadual.to_s[0..13].ljust(14)}#{self.it_in_ultima_fac.to_s[0..0]}"
		end

		if fields_empty? [self.it_nu_inscricao_estadual, self.it_da_transacao, self.it_ho_transacao]
			self.sp_insc_data_hora = nil
		else
			self.sp_insc_data_hora = "#{self.it_nu_inscricao_estadual.to_s[0..13].ljust(14)}#{self.it_da_transacao.to_s[0..7].ljust(8)}#{self.it_ho_transacao.to_s[0..5]}"
		end

		if fields_empty? [self.it_co_natureza_juridica, self.it_in_ultima_fac]
			self.sp_natureza_ultima = nil
		else
			self.sp_natureza_ultima = "#{self.it_co_natureza_juridica.to_s[0..1].ljust(2)}#{self.it_in_ultima_fac.to_s[0..0]}"
		end

		if fields_empty? [self.it_co_regiao_fiscal, self.it_nu_inscricao_estadual, self.it_in_ultima_fac]
			self.sp_regiao_inscricao_ultima = nil
		else
			self.sp_regiao_inscricao_ultima = "#{self.it_co_regiao_fiscal.to_s[0..2].ljust(3)}#{self.it_nu_inscricao_estadual.to_s[0..13].ljust(14)}#{self.it_in_ultima_fac.to_s[0..0]}"
		end

		if fields_empty? [self.it_co_regime_enquadramento, self.it_in_ultima_fac]
			self.sp_regime_enq_ultima = nil
		else
			self.sp_regime_enq_ultima = "#{self.it_co_regime_enquadramento.to_s[0..0].ljust(1)}#{self.it_in_ultima_fac.to_s[0..0]}"
		end

		if fields_empty? [self.it_co_regime_pagamento, self.it_in_ultima_fac]
			self.sp_regime_pgto_ultima = nil
		else
			self.sp_regime_pgto_ultima = "#{self.it_co_regime_pagamento.to_s[0..2].ljust(3)}#{self.it_in_ultima_fac.to_s[0..0]}"
		end

	end
	
end