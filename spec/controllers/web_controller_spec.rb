require "spec_helper"

describe WebController do
  describe "#index" do
    it "renders the index action" do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
