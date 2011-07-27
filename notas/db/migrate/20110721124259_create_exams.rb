class CreateExams < ActiveRecord::Migration
  def self.up
    create_table :exams do |t|
      t.date :date
      t.integer :part_id

      t.timestamps
    end
  end

  def self.down
    drop_table :exams
  end
end
