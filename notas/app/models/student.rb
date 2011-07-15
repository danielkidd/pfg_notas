class Student < User
  has_many :signatures_students

  validates_presence_of     :expedient
  validates_length_of       :expedient,    :within => 5..40
  validates_uniqueness_of   :expedient

  attr_accessible :expedient

  def expedient=(value)
    write_attribute :expedient, (value ? value.downcase : nil)
  end

  def find_signatures(year_id)
    Signature.find :all,
      :conditions=>['year_id=? AND student_id=?',year_id, self.id],
      :joins=>'INNER JOIN signatures_students ON signature_id=signatures.id'
  end

  def find_signature(signature_id, year_id)
    Signature.find signature_id,
      :conditions=>['year_id=? AND student_id=?',year_id, self.id],
      :joins=>'INNER JOIN signatures_students ON signature_id=signatures.id'
  end

end
