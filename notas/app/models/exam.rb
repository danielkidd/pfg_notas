class Exam < ActiveRecord::Base
  belongs_to :part
  has_many :evaluations

  validates_presence_of     :part_id
  validates_presence_of     :date

  before_destroy :comprueba_dependencias
  def comprueba_dependencias
    raise 'No se puede borrar este examen' unless evaluations.blank?
  end
end
