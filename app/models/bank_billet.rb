# frozen_string_literal: true

class BankBillet < ApplicationRecord
  enum customer_state: {
    ac: 'AC', al: 'AL', ap: 'AP', am: 'AM', ba: 'BA', ce: 'CE', df: 'DF', es: 'ES', go: 'GO', ma: 'MA', mt: 'MT',
    ms: 'MS', mg: 'MG', pa: 'PA', pb: 'PB', pr: 'PR', pe: 'PE', pi: 'PI', rj: 'RJ', rn: 'RN', rs: 'RS', ro: 'RO',
    rr: 'RR', sc: 'SC', sp: 'SP', se: 'SE', to: 'TO'
  }
end
