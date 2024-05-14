class AddExtrasToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :extra_fee_discount, :float
    add_column :orders, :extra_fee_discount_description, :string
    add_column :orders, :payment_method_used, :string
    add_column :orders, :expiration_date, :date

  end
end
