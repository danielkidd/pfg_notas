class Year < ActiveRecord::Base
  validates_presence_of     :start_year
  validates_numericality_of :start_year
  validates_uniqueness_of   :start_year

  default_scope :order => :start_year

  def self.current
    current_year = Date.today.year
    current_year -= 1 unless Date.today.month > 9
    find_or_create_by_start_year current_year
  end

  def end_year
    start_year + 1
  end

  def to_s
    "#{start_year}/#{end_year}"
  end
end
