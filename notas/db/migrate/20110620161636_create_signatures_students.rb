class CreateSignaturesStudents < ActiveRecord::Migration
  def self.up
    create_table :signatures_students do |t|
      t.integer :signature_id
      t.integer :student_id
      t.integer :year_id
      t.decimal :average1, :precision => 4, :scale => 2
      t.integer :calification1
      t.decimal :average2, :precision => 4, :scale => 2
      t.integer :calification2
      t.boolean :ordinary
    end

    add_index :signatures_students, [:signature_id, :student_id, :year_id], :unique=>true
  end

  def self.down
     drop_table :signatures_students
  end
end
