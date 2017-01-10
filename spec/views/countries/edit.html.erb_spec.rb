require 'rails_helper'

RSpec.describe "countries/edit", type: :view do
  before(:each) do
    @country = assign(:country, Country.create!(
      :country => "MyString",
      :country_code => "MyString",
      :currency => "MyString",
      :currency_code => "MyString",
      :active => false
    ))
  end

  it "renders the edit country form" do
    render

    assert_select "form[action=?][method=?]", country_path(@country), "post" do

      assert_select "input#country_country[name=?]", "country[country]"

      assert_select "input#country_country_code[name=?]", "country[country_code]"

      assert_select "input#country_currency[name=?]", "country[currency]"

      assert_select "input#country_currency_code[name=?]", "country[currency_code]"

      assert_select "input#country_active[name=?]", "country[active]"
    end
  end
end
