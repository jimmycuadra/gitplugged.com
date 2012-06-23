class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string :name
      t.integer :vote_sum
      t.date :week_start

      t.timestamps
    end
  end
end
