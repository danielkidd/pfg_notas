class CreateSignaturesTeachers < ActiveRecord::Migration
  def self.up
    create_table :signatures_teachers do |t|
      t.integer :signature_id
      t.integer :teacher_id
      t.integer :year_id
    end

    add_index :signatures_teachers, [:signature_id, :teacher_id, :year_id], :unique=>true
  end

  def self.down
    drop_table :signatures_teachers
  end
end
