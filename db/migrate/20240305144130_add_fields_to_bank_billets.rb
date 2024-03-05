class AddFieldsToBankBillets < ActiveRecord::Migration[7.1]
  def change
    add_column :bank_billets, :paid_at, :datetime
    add_column :bank_billets, :status, :string
    add_column :bank_billets, :registration_status, :string
    add_column :bank_billets, :paid_amount, :decimal
    add_column :bank_billets, :url, :string
  end
end
