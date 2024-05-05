class CreatePaymentMethods < ActiveRecord::Migration[7.1]
  def change
    create_table :payment_methods do |t|
      t.boolean :cash
      t.boolean :credit_card
      t.boolean :debit_card
      t.boolean :bank_transfer
      t.boolean :paypal
      t.boolean :check
      t.boolean :pix
      t.boolean :bitcoin
      t.boolean :google_pay
      t.references :buffet, null: false, foreign_key: true

      t.timestamps
    end

    remove_column :buffets, :playment_methods, :string
  end
end
