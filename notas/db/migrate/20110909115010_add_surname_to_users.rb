class AddSurnameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :surname, :string, :limit => 100, :default => '', :null => true
  end

  def self.down
    remove_column :users, :surname
  end
end
