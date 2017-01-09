class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name, :null => false
      t.string :email, :null => false
      t.string :country, :default => "Deutschland"
      t.string :country_code, :default => "DE"
      t.string :currency, :default => "Euro"
      t.string :currency_code, :default => "EUR"
      t.boolean :active, :default => true
      t.timestamps
    end
  end
end
