class SignaturesTeacher < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :signature
  belongs_to :year
  validates_presence_of :teacher_id
  validates_presence_of :signature_id
  validates_presence_of :year_id
end
