class ChangeCalificationsTypeToDecimal < ActiveRecord::Migration
  def self.up
    change_column :signatures_students, :calification1, :decimal, :precision => 4, :scale => 2
    change_column :signatures_students, :calification2, :decimal, :precision => 4, :scale => 2
  end

  def self.down
    change_column :signatures_students, :calification1, :integer
    change_column :signatures_students, :calification2, :integer
  end
end
