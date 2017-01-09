require 'rails_helper'

RSpec.describe "comments/edit", type: :view do
  before(:each) do
    @user     = assign(:user, (create :user, :andy) )
    @article  = assign(:article, (create :article, :active, parent_id: @user.id, user_id: @user.id) )
    @comment  = assign(:comment, (create :comment, :active, parent_id: @article.id, user_id: @user.id) )
  end

  it "renders the edit comment form" do
   
    render

    assert_select "form[action=?][method=?]", comment_path(@comment), "post" do
      assert_select "input#comment_title[name=?]", "comment[title]"
      assert_select "textarea#comment_content[name=?]", "comment[content]"
      assert_select "input#comment_active[name=?]", "comment[active]"
    end
  end
end
