class CreateParts < ActiveRecord::Migration
  def self.up
    create_table :parts do |t|
      t.text :description
      t.decimal :weighted, :precision => 5, :scale => 2
      t.integer :parent_id
      t.decimal :min_compensable, :precision => 4, :scale => 2
      t.boolean :ordinary
      t.integer :signature_id
      t.integer :year_id

      t.timestamps
    end
  end

  def self.down
    drop_table :parts
  end
end
