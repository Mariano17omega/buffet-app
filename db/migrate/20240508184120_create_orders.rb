class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.date :date_event
      t.integer :num_guests
      t.string :code
      t.string :details
      t.string :address_event
      t.integer :status,  default: 0
      t.references :user_client, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
