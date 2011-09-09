class Student < User
  has_many :signatures_students, :dependent => :destroy

  validates_presence_of     :expedient
  validates_length_of       :expedient,    :within => 5..40
  validates_uniqueness_of   :expedient

  attr_accessible :expedient

  def expedient=(value)
    write_attribute :expedient, (value ? value.downcase : nil)
  end

  def find_signatures(year_id)
    Signature.find :all, :select=>'DISTINCT signatures.*',
      :conditions=>['year_id=? AND student_id=?',year_id, self.id],
      :joins=>'INNER JOIN signatures_students ON signature_id=signatures.id'
  end

  def find_signature(signature_id, year_id)
    Signature.find signature_id, :select=>'DISTINCT signatures.*',
      :conditions=>['year_id=? AND student_id=?',year_id, self.id],
      :joins=>'INNER JOIN signatures_students ON signature_id=signatures.id'
  end

  def self.search(year_id, degree_id)
    find :all, :select=>'DISTINCT users.*',
      :conditions=>['(year_id=? OR year_id IS NULL) AND (degree_id=? OR degree_id IS NULL)', year_id, degree_id],
      :joins=>[
        'LEFT JOIN signatures_students ON student_id=users.id',
        'LEFT JOIN signatures ON signature_id=signatures.id'
        ]
  end

  def to_s
    "#{expedient} - #{name}"
  end
end
