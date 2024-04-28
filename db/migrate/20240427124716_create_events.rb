class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.integer :min_guests
      t.integer :max_guests
      t.integer :duration
      t.string :menu
      t.boolean :alcoholic_beverages
      t.boolean :decoration
      t.boolean :parking_servise
      t.boolean :event_location
      t.references :buffet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
