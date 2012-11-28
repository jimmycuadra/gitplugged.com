#= require spec_helper
#= require models/repo

describe "gp.Repo", ->
  describe "#points", ->
    it "represents the vote_sum as an integer", ->
      repo = new gp.Repo(vote_sum: 1.1)

      expect(repo.points()).to.equal(1)
