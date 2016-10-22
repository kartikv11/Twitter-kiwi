class CreateUsers < ActiveRecord::Migration
  #
  # [up description]
  #
  # create table users
  #
  # user_name (string) to store the user name of user which is unique
  # name (string) to store the name of user
  # email_id (string) to store the email id of the user
  # password_digest (string) securely hashed password_digest attribute
  #
  def up
    create_table :users do |t|
      t.string :user_name, unique: true
      t.string :name
      t.string :email_id, unique: true
      t.string :password_digest
      t.timestamps null: false
    end

    add_index :users, :email_id, unique: true
    add_index :users, :user_name, unique: true
  end

  #
  # [down description]
  #
  # drop table user for rollback
  #
  def down
    drop_table :users
  end
end
