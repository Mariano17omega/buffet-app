class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :cpf
      t.references :user_client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
