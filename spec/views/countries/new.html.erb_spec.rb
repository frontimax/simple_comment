require 'rails_helper'

RSpec.describe "countries/new", type: :view do
  before(:each) do
    assign(:country, Country.new(
      :country => "MyString",
      :country_code => "MyString",
      :currency => "MyString",
      :currency_code => "MyString",
      :active => false
    ))
  end

  it "renders new country form" do
    render

    assert_select "form[action=?][method=?]", countries_path, "post" do

      assert_select "input#country_country[name=?]", "country[country]"

      assert_select "input#country_country_code[name=?]", "country[country_code]"

      assert_select "input#country_currency[name=?]", "country[currency]"

      assert_select "input#country_currency_code[name=?]", "country[currency_code]"

      assert_select "input#country_active[name=?]", "country[active]"
    end
  end
end
