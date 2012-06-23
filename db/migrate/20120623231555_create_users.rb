class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :twitter_uid
      t.string :name

      t.timestamps
    end

    add_index :users, :twitter_uid
  end
end
