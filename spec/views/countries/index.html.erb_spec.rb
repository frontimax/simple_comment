require 'rails_helper'

RSpec.describe "countries/index", type: :view do
  before(:each) do
    assign(:countries, [
      Country.create!(
        :country => "Country",
        :country_code => "Country Code",
        :currency => "Currency",
        :currency_code => "Currency Code",
        :active => false
      ),
      Country.create!(
        :country => "Country",
        :country_code => "Country Code",
        :currency => "Currency",
        :currency_code => "Currency Code",
        :active => false
      )
    ])
  end

  it "renders a list of countries" do
    render
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    assert_select "tr>td", :text => "Country Code".to_s, :count => 2
    assert_select "tr>td", :text => "Currency".to_s, :count => 2
    assert_select "tr>td", :text => "Currency Code".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
