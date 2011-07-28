class SignaturesStudent < ActiveRecord::Base
  belongs_to :student
  belongs_to :signature
  belongs_to :year
  has_many :evaluations
  
  validates_inclusion_of :calification1, :in=>0..10, :allow_nil=>true
  validates_inclusion_of :average1, :in=>0..10, :allow_nil=>true
  validates_inclusion_of :calification2, :in=>0..10, :allow_nil=>true
  validates_inclusion_of :average2, :in=>0..10, :allow_nil=>true
  validates_presence_of :student_id
  validates_presence_of :signature_id
  validates_presence_of :year_id

  validate_on_create :comprueba_extraordinaria
  def comprueba_extraordinaria
    unless ordinary
      ordinarias = self.class.find(:all, :conditions=>{
        :student_id=>student_id, :signature_id=>signature_id, :ordinary=>true})
      errors.add :ordinary, 'El alumno no puede cursar esta asignatura por extraordinaria' unless ordinarias.any?
    end
  end

  validate_on_create :comprueba_titulacion
  def comprueba_titulacion
    unless signature.blank? || year.blank? || student.blank?
      signatures = student.find_signatures(year_id)
      errors.add :signature_id, 'El alumno no puede cursar asignaturas de distintas titulaciones en el mismo curso' unless signatures.empty? || signatures.first.degree_id == signature.degree_id
    end
  end

  before_destroy :comprueba_dependencias
  def comprueba_dependencias
    raise 'No se puede borrar esta matrícula' unless evaluations.blank?
  end

  def student_name
    student.name
  end
end
