require 'rails_helper'

RSpec.describe BankBillet, type: :model do
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:expire_at) }
  it { should validate_presence_of(:customer_address) }
  it { should validate_presence_of(:customer_city_name) }
  it { should validate_presence_of(:customer_neighborhood) }
  it { should validate_presence_of(:customer_person_name) }
  it { should validate_presence_of(:customer_state) }
  it { should validate_presence_of(:customer_zipcode) }

  it { should validate_numericality_of(:amount).is_greater_than(0) }
end
