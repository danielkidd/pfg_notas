class SignaturesStudent < ActiveRecord::Base
  belongs_to :student
  belongs_to :signature
  belongs_to :year
  has_many :evaluations

  validates_inclusion_of :calification, :in=>0..10, :allow_nil=>true
  validates_presence_of :student_id
  validates_presence_of :signature_id
  validates_presence_of :year_id
end
