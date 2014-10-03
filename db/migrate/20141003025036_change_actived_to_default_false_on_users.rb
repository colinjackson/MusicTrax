class ChangeActivedToDefaultFalseOnUsers < ActiveRecord::Migration
  def change
    change_column :users, :activated, :boolean, null: false, default: false
  end
end
