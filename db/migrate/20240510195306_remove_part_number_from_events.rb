class RemovePartNumberFromEvents < ActiveRecord::Migration[7.1]
  def change
    remove_column :events, :max_guests, :integer
  end
end
