require 'rails_helper'

RSpec.describe "countries/show", type: :view do
  before(:each) do
    @country = assign(:country, Country.create!(
      :country => "Country",
      :country_code => "Country Code",
      :currency => "Currency",
      :currency_code => "Currency Code",
      :active => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Country/)
    expect(rendered).to match(/Country Code/)
    expect(rendered).to match(/Currency/)
    expect(rendered).to match(/Currency Code/)
    expect(rendered).to match(/false/)
  end
end
