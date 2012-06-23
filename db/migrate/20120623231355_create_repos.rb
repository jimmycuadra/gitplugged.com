class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string :name
      t.integer :vote_sum
      t.date :week_start

      t.timestamps
    end

    add_index :repos, [:week_start, :vote_sum]
    add_index :repos, :name
  end
end
