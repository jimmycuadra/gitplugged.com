FactoryGirl.define do
  factory :repo do
    sequence(:name) { |n| "foo/bar#{n}" }
    vote_sum 1.0
    week_start { Date.today.beginning_of_week }
  end

  factory :user do
    name "Joe Blow"
    twitter_uid "abcdefg"
  end

  factory :vote do
    user
    repo

    value 30.0
  end
end
