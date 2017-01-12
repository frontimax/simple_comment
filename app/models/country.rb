class Country < ApplicationRecord
  
  def self.insert_countries(countries)
    return if countries.blank?
    Country.destroy.all
    countries.map do |country|
      next if country.blank?
      Country.create(
        country: country.strip,
      )
    end
  end
  
  private
end
