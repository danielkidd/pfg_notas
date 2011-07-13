module SignaturesHelper

  def new_students # alumnos que aun no tienen esa asignatura
    signatures_students = @signature.signatures_students.find(:all, :conditions=>['year_id=?',@year_selected.id])
    return Student.all unless signatures_students.any?
    student_ids = signatures_students.collect { |signatures_student| signatures_student.student_id }
    Student.all :conditions=>['id not in (?)', student_ids]
  end
  def new_teachers # Profesores que aun no imparten esa asignatura
    signatures_teachers = @signature.signatures_teachers.find(:all, :conditions=>['year_id=?',@year_selected.id])
    return Teacher.all unless signatures_teachers.any?
    teacher_ids = signatures_teachers.collect { |signatures_teacher| signatures_teacher.teacher_id }
    Teacher.all :conditions=>['id not in (?)', teacher_ids]
  end

end
