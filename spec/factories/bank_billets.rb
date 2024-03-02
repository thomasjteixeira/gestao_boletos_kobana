FactoryBot.define do
  factory :bank_billet do
    amount { Faker::Commerce.price(range: 1..1000.0).to_f }
    description do
      "Compras na empresa #{Faker::Company.name} do produto #{Faker::Commerce.product_name} #{Faker::Number.number(digits: 4)}"
    end
    expire_at { Faker::Date.forward(days: 23) }
    customer_address { Faker::Address.street_address }
    customer_address_complement { Faker::Address.secondary_address }
    customer_address_number { Faker::Address.building_number }
    customer_city_name { Faker::Address.city }
    customer_cnpj_cpf { Faker::CPF.pretty }
    customer_email { Faker::Internet.email }
    customer_neighborhood { Faker::Address.community }
    customer_person_name { Faker::Name.name }
    customer_person_type { %w[individual company].sample }
    customer_phone_number { "(#{Faker::Number.number(digits: 2)}) #{Faker::Number.number(digits: 1)} #{Faker::Number.number(digits: 4)}-#{Faker::Number.number(digits: 4)}" }
    customer_state { BankBillet.customer_states.keys.sample.to_s }
    customer_zipcode { Faker::Number.number(digits: 8).to_s.insert(5, '-') }
  end
end
