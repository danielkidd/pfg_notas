class Teacher < User
  has_many :signatures_teachers, :dependent => :destroy

  def find_signatures(year_id, degree_id)
    Signature.find :all, :select=>'DISTINCT signatures.*',
      :conditions=>['year_id=? AND degree_id=? AND teacher_id=?', year_id, degree_id, self.id],
      :joins=>'INNER JOIN signatures_teachers ON signature_id=signatures.id'
  end

  def find_signature(signature_id, year_id, degree_id)
    Signature.find signature_id, :select=>'DISTINCT signatures.*',
      :conditions=>['year_id=? AND degree_id=? AND teacher_id=?',year_id, degree_id, self.id],
      :joins=>'INNER JOIN signatures_teachers ON signature_id=signatures.id'
  rescue
    raise 'Acceso no permitido'
  end

  def self.search(year_id, degree_id)
    find :all, :select=>'DISTINCT users.*', :order=>'year_id, name',
      :conditions=>['(year_id=? OR year_id IS NULL) AND (degree_id=? OR degree_id IS NULL)', year_id, degree_id],
      :joins=>[
        'LEFT JOIN signatures_teachers ON teacher_id=users.id',
        'LEFT JOIN signatures ON signature_id=signatures.id'
        ]
  end
end
