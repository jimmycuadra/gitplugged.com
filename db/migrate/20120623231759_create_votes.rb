class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :repo_id
      t.integer :value

      t.timestamps
    end

    add_index :votes, [:repo_id, :value]
    add_index :votes, :user_id
  end
end
