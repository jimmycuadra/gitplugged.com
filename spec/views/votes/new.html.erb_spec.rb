require 'spec_helper'

describe "votes/new" do
  before(:each) do
    assign(:vote, stub_model(Vote,
      :user_id => 1,
      :repo_id => 1,
      :value => 1
    ).as_new_record)
  end

  it "renders new vote form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => votes_path, :method => "post" do
      assert_select "input#vote_user_id", :name => "vote[user_id]"
      assert_select "input#vote_repo_id", :name => "vote[repo_id]"
      assert_select "input#vote_value", :name => "vote[value]"
    end
  end
end
