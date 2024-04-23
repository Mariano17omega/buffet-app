class CreateBuffets < ActiveRecord::Migration[7.1]
  def change
    create_table :buffets do |t|
      t.string :brand_name
      t.string :corporate_name
      t.integer :cnpj
      t.integer :contact_phone
      t.string :contact_email
      t.string :address
      t.string :district
      t.string :state
      t.string :city
      t.string :cep
      t.string :description
      t.string :playment_methods
      t.references :user_owner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
