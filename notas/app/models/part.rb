class Part < ActiveRecord::Base
  belongs_to :signature
  belongs_to :year
  has_many :exams, :dependent => :destroy
  acts_as_tree

  validates_presence_of     :signature_id
  validates_presence_of     :year_id
  validates_presence_of     :description
  validates_numericality_of :weighted, :greater_than=>0, :less_than_or_equal_to=>100
  validates_numericality_of :min_compensable, :greater_than_or_equal_to=>0, :less_than_or_equal_to=>10

  def last_evaluation(student)
    Evaluation.find :first,
      :joins=>[ 'INNER JOIN exams ON evaluations.exam_id=exams.id',
      'INNER JOIN signatures_students ON evaluations.signatures_student_id=signatures_students.id' ],
      :conditions=> {'signatures_students.student_id'=>student, 'exams.part_id'=>self},
      :order=>'exams.date DESC'
  end

  def calcular_nota(signatures_student, conv)
    evaluation = Evaluation.find :last,
      :joins=>'inner join exams on evaluations.exam_id = exams.id',
      :conditions=>[
        'evaluations.signatures_student_id=? AND MONTH(exams.date)<=? AND exams.part_id=?',
        signatures_student.id, (conv==1 ? 7 : 12), self.id
      ], :order=>'exams.date ASC'
      return evaluation.calification unless evaluation.blank?
    average = nil
    self.children.each do |part|
      nota = part.calcular_nota(signatures_student, conv)
      unless nota.nil? || nota < part.min_compensable
        average = 0 if average.nil?
        average += (nota * part.weighted / 100)
      else
        average = nil
        break
      end
    end
    average
  end
end
