#= require spec_helper
#= require views/repo

describe "GP.Views.Repo", ->
  beforeEach ->
    @view = new GP.Views.Repo(model: SpecHelper.model)

  describe "#render", ->
    it "renders the template into the view's DOM element", ->
      @view.template = SpecHelper.template

      @view.render()

      expect(@view.$el).to.have.text("Hello, Foo!")
