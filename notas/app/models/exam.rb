class Exam < ActiveRecord::Base
  belongs_to :part
  has_many :evaluations

  validates_presence_of     :part_id
  validates_presence_of     :date

  accepts_nested_attributes_for :evaluations, :allow_destroy=>true,
    :reject_if => proc { |attributes| attributes['calification'].blank? }

  before_validation_on_create :init_evaluations
  def init_evaluations
    evaluations.each { |e| e.exam = self }
  end

  before_destroy :comprueba_dependencias
  def comprueba_dependencias
    raise 'No se puede borrar este examen' unless evaluations.blank?
  end

  def new_signatures_students
    return nil unless part.present?
    SignaturesStudent.find :all, :conditions=>{
      :ordinary     => part.ordinary,
      :signature_id => part.signature,
      :year_id => part.year
    }
  end
end
