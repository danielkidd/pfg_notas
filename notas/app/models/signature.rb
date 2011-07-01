class Signature < ActiveRecord::Base
  has_and_belongs_to_many :teachers, :order=>:name
  has_and_belongs_to_many :students, :order=>:name
  has_many :signatures_students
  has_many :signatures_teachers
  has_many :tests

  validates_presence_of     :name
  validates_length_of       :name,     :maximum => 100
  validates_uniqueness_of   :name

  # devuelve un array con los nombres de los profesores
  def teacher_names
    teachers.to_enum.collect { |teacher| teacher.name }
  end
 
end
