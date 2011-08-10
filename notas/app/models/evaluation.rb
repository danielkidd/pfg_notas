class Evaluation < ActiveRecord::Base
  belongs_to :exam
  belongs_to :signatures_student

  validates_presence_of   :exam
  validates_presence_of   :signatures_student
  validates_uniqueness_of :signatures_student_id, :scope => :exam_id
  validates_numericality_of :calification, :greater_than_or_equal_to=>0, :less_than_or_equal_to=>10

  validate_on_create :comprueba_matricula
  def comprueba_matricula
    unless exam.blank? || signatures_student.blank?
      errors.add :signatures_student_id, 'El alumno no puede realizar este examen' unless signatures_student.signature == exam.part.signature && signatures_student.year == exam.part.year && signatures_student.ordinary == exam.part.ordinary
    end
  end
end
