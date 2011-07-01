class Student < User

  has_and_belongs_to_many :signatures, :uniq=>true, :order=>:name
  has_many :signatures_students

  validates_presence_of     :expedient
  validates_length_of       :expedient,    :within => 5..40
  validates_uniqueness_of   :expedient

  attr_accessible :expedient

  def signatures_names
    signatures.to_enum.collect { |signature| signature.name }
  end

  def expedient=(value)
    write_attribute :expedient, (value ? value.downcase : nil)
  end

end
