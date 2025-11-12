class Sitafe::SitafeHistContrAtivSecund < ApplicationRecord
	
	belongs_to :sitafe_historico_contribuinte, foreign_key: 'tuk', primary_key: 'tuk'

	self.table_name = 'SITAFE.SITAFE_HIST_CONTR_ATIV_SECUND'
	self.primary_key = 'tuk'
	
	def initialize(options = {})
		super

		if self.m_occurs == 0
			last_m_occurs_of_tuk = Sitafe::SitafeHistContrAtivSecund.where(tuk: self.tuk).last

			if last_m_occurs_of_tuk == nil
				last_m_occurs_of_tuk = 1
			else
				last_m_occurs_of_tuk = last_m_occurs_of_tuk.m_occurs + 1
			end

			self.m_occurs = last_m_occurs_of_tuk
		end
	end
			
	
end