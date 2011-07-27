class Exam < ActiveRecord::Base
  belongs_to :part
  has_many :evaluations

  validates_presence_of     :part_id
  validates_presence_of     :date
end
