# frozen_string_literal: true

json.extract! bank_billet, :id, :amount, :description, :expire_at, :customer_address, :customer_address_complement,
              :customer_address_number, :customer_city_name, :customer_cnpj_cpf, :customer_email, :customer_neighborhood, :customer_person_name, :customer_person_type, :customer_phone_number, :customer_state, :customer_zipcode, :created_at, :updated_at
json.url bank_billet_url(bank_billet, format: :json)
