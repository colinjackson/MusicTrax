class CreateSignIns < ActiveRecord::Migration
  def change
    create_table :sign_ins do |t|
      t.references :user, index: true, null: false
      t.string :session_token, null: false

      t.timestamps
    end
    
    add_index :sign_ins, :session_token, unique: true
  end
end
