class CreateRelationships < ActiveRecord::Migration

  #
  # [up description]
  #
  # create table relationships
  #
  # follower_id (integer) to store user id who is following
  # following_id (integer) to store user id of user who is followed
  #
  def up
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :following_id

      t.timestamps null: false
    end

    add_index :relationships, :follower_id
    add_index :relationships, :following_id
    add_index :relationships, [:follower_id, :following_id], unique: true
  end

  #
  # [down description]
  #
  # drop table relationships for rollback
  #
  def down
    drop_table :relationships
  end
end
