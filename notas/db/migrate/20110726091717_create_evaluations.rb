class CreateEvaluations < ActiveRecord::Migration
  def self.up
    create_table :evaluations do |t|
      t.decimal :calification
      t.integer :exam_id
      t.integer :signatures_student_id

      t.timestamps
    end
  end

  def self.down
    drop_table :evaluations
  end
end
