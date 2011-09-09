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

  accepts_nested_attributes_for :signatures_students

  before_destroy :comprueba_dependencias
  def comprueba_dependencias
    raise 'No se puede borrar esta asignatura' unless signatures_students.blank? && signatures_teachers.blank? && parts.blank?
  end

  # devuelve un array con los nombres de los profesores
  def teacher_names(year_id)
    teachers.find(:all, :conditions=>['year_id=?',year_id]).to_enum.collect { |teacher| teacher.name }
  end

  def calcular_medias(ordinary, conv, year_id)
    SignaturesStudent.transaction do
      condiciones = {:ordinary=>ordinary, :year_id=>year_id}
      if conv==1
        condiciones[:enabled1] = true
      else
        condiciones[:enabled2] = true
      end
      signatures_students.find(:all, :conditions=>condiciones).each do |signatures_student|
        average = nil
        parts.find(:all, :conditions=>{:ordinary=>ordinary, :year_id=>year_id, :parent_id=>nil}).each do |part|
          nota = part.calcular_nota(signatures_student, conv)
          unless nota.nil? || nota < part.min_compensable
            average = 0 if average.nil?
            average += (nota * part.weighted / 100)
          else
            average = nil
            break
          end
        end
        average = 10 if average.present? && average > 10
        if conv==1
          signatures_student.average1 = average
        else
          cant_examenes_sep = signatures_student.evaluations.count(
            :joins=>'inner join exams on evaluations.exam_id = exams.id',
            :conditions=>['MONTH(exams.date)>?', 7])
          signatures_student.average2 = average unless cant_examenes_sep==0
        end
        signatures_student.save
      end
    end
  end
 
end
