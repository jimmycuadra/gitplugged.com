require 'spec_helper'

describe "votes/edit" do
  before(:each) do
    @vote = assign(:vote, stub_model(Vote,
      :user_id => 1,
      :repo_id => 1,
      :value => 1
    ))
  end

  it "renders the edit vote form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => votes_path(@vote), :method => "post" do
      assert_select "input#vote_user_id", :name => "vote[user_id]"
      assert_select "input#vote_repo_id", :name => "vote[repo_id]"
      assert_select "input#vote_value", :name => "vote[value]"
    end
  end
end
