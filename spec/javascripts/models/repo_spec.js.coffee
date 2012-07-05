#= require spec_helper
#= require models/repo

describe "Repo", ->
  describe "#points", ->
    it "represents the vote_sum as an integer", ->
      repo = new GP.Models.Repo(vote_sum: 1.1)

      expect(repo.points()).to.equal(1)
