class Teacher < User
  has_and_belongs_to_many :signatures, :uniq=>true, :order=>:name
  has_many :signatures_teachers
end
