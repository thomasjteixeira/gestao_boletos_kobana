FactoryBot.define do
  factory :bank_billet do
    amount { Faker::Commerce.price(range: 0..10000.0) }
    description { "Compras na empresa #{Faker::Company.name} do produto #{Faker::Commerce.product_name} #{Faker::Number.number(digits: 4)}" }
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
    customer_phone_number { Faker::PhoneNumber.phone_number }
    customer_state { BankBillet.customer_states.keys.sample.to_s }
    customer_zipcode { Faker::Number.number(digits: 8).to_s.insert(5, '-') }
  end
end
