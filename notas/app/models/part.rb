class Part < ActiveRecord::Base
  belongs_to :signature
  belongs_to :year
  has_many :exams
  acts_as_tree

  validates_presence_of     :signature_id
  validates_presence_of     :year_id
  validates_presence_of     :description
  validates_numericality_of :weighted, :greater_than=>0, :less_than_or_equal_to=>100
  validates_numericality_of :min_compensable, :greater_than_or_equal_to=>0, :less_than_or_equal_to=>10

end
