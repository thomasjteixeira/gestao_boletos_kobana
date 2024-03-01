# frozen_string_literal: true

class CreateBankBillets < ActiveRecord::Migration[7.1]
  def change
    create_table :bank_billets do |t|
      t.decimal :amount, null: false
      t.string :description, null: false
      t.date :expire_at, null: false
      t.string :customer_address, null: false
      t.string :customer_address_complement
      t.string :customer_address_number
      t.string :customer_city_name, null: false
      t.string :customer_cnpj_cpf
      t.string :customer_email
      t.string :customer_neighborhood, null: false
      t.string :customer_person_name, null: false
      t.string :customer_person_type
      t.string :customer_phone_number
      t.string :customer_state, null: false
      t.string :customer_zipcode, null: false

      t.timestamps
    end
  end
end
