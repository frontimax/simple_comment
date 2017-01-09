class ChangeDefaultsOfUser < ActiveRecord::Migration[5.0]
  def up
    change_column :users, :country, :string, default: 'Germany'
    change_column :users, :country_code, :string, default: 'de'
    change_column :users, :currency, :string, default: 'Mark'
    change_column :users, :currency_code, :string, default: 'DEM'
  end

  def down
    change_column :users, :country, :string, default: 'Deutschland'
    change_column :users, :country_code, :string, default: 'DE'
    change_column :users, :currency, :string, default: 'Euro'
    change_column :users, :currency_code, :string, default: 'ER'
  end
end
