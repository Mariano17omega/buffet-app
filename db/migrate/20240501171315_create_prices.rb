class CreatePrices < ActiveRecord::Migration[7.1]
  def change
    create_table :prices do |t|
      t.float :price_base_weekdays
      t.float :price_add_weekdays
      t.float :price_overtime_weekdays
      t.float :price_base_weekend
      t.float :price_add_weekend
      t.float :price_overtime_weekend
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
