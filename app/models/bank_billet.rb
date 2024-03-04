# frozen_string_literal: true

class BankBillet < ApplicationRecord
  enum customer_state: {
    ac: 'AC', al: 'AL', ap: 'AP', am: 'AM', ba: 'BA', ce: 'CE', df: 'DF', es: 'ES', go: 'GO', ma: 'MA', mt: 'MT',
    ms: 'MS', mg: 'MG', pa: 'PA', pb: 'PB', pr: 'PR', pe: 'PE', pi: 'PI', rj: 'RJ', rn: 'RN', rs: 'RS', ro: 'RO',
    rr: 'RR', sc: 'SC', sp: 'SP', se: 'SE', to: 'TO'
  }

  validates_presence_of :amount, :description, :expire_at, :customer_address, :customer_city_name,
                        :customer_neighborhood, :customer_person_name, :customer_state, :customer_zipcode

  validates_numericality_of :amount, greater_than: 0
end
