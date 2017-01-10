class CreateCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :countries do |t|
      t.string :country
      t.string :country_code
      t.string :currency
      t.string :currency_code
      t.boolean :active

      t.timestamps
    end
  end
end
