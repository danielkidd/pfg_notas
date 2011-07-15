class Degree < ActiveRecord::Base
  has_many :signatures

  validates_presence_of     :name
  validates_uniqueness_of   :name

  before_destroy :comprueba_dependencias
  def comprueba_dependencias
    raise 'No se puede borrar esta titulacion' unless signatures.blank?
  end

  default_scope :order => :name
end
