class Signature < ActiveRecord::Base
  has_and_belongs_to_many :teachers, :order=>:name
  has_and_belongs_to_many :students, :order=>:name
  has_many :signatures_students
  has_many :signatures_teachers
  belongs_to :degree
  has_many :parts

  validates_presence_of     :degree_id
  validates_presence_of     :name
  validates_length_of       :name,     :maximum => 100
  validates_uniqueness_of   :name,     :scope=>:degree_id

  before_destroy :comprueba_dependencias
  def comprueba_dependencias
    raise 'No se puede borrar esta asignatura' unless signatures_students.blank? && signatures_teachers.blank? && parts.blank?
  end

  # devuelve un array con los nombres de los profesores
  def teacher_names(year_id)
    teachers.find(:all, :conditions=>['year_id=?',year_id]).to_enum.collect { |teacher| teacher.name }
  end
 
end
