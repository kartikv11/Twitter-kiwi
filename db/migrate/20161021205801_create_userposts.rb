class CreateUserposts < ActiveRecord::Migration

  #
  # [up description]
  #
  # create table userposts
  #
  # content (text) to store user post content
  #
  def up
    create_table :userposts do |t|
      t.text :content
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :userposts, [:user_id, :created_at]

  end

  #
  # [down description]
  #
  # drop table userposts for rollback
  #
  def down
    drop_table :userposts
  end
end
