class Teacher < User
  has_many :signatures_teachers

  def find_signatures(year_id, degree_id)
    Signature.find :all,
      :conditions=>['year_id=? AND degree_id=? AND teacher_id=?', year_id, degree_id, self.id],
      :joins=>'INNER JOIN signatures_teachers ON signature_id=signatures.id'
  end

  def find_signature(signature_id, year_id, degree_id)
    Signature.find signature_id,
      :conditions=>['year_id=? AND degree_id=? AND teacher_id=?',year_id, degree_id, self.id],
      :joins=>'INNER JOIN signatures_teachers ON signature_id=signatures.id'
  end

  def self.search(year_id, degree_id)
    find :all,
      :conditions=>['year_id=? AND degree_id=?', year_id, degree_id],
      :joins=>[
        'INNER JOIN signatures_teachers ON teacher_id=users.id',
        'INNER JOIN signatures ON signature_id=signatures.id'
        ]
  end
end
