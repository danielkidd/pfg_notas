module ExamsHelper

  def new_signatures_students # alumnos que aun no tienen ese examen pero se pueden examinar
    condition = 'year_id = :year_id AND ordinary = :ordinary'
    condition_values = {:year_id=>@year_selected, :ordinary=>@ordinary}
    unless @exam.evaluations.blank?
      condition += ' AND id not in (:ids)'
      condition_values[:ids] = @exam.evaluations.collect { |evaluation| evaluation.signatures_student_id }
    end
    @signature.signatures_students.find :all, :conditions=>[condition, condition_values]
  end

end
