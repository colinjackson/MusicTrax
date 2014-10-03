class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :text, null: false
      t.references :user, index: true, null: false
      t.references :track, index: true, null: false

      t.timestamps
    end
  end
end
