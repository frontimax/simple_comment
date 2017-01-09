class CreateSegments < ActiveRecord::Migration[5.0]
  def change
    create_table :segments do |t|
      t.integer :user_id
      t.string :type
      t.string :parent_type
      t.integer :parent_id
      t.string :title, :null => false
      t.text :content, :null => false
      t.boolean :active, :default => true
      t.timestamps
    end
  end
end
