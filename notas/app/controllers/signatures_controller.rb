class SignaturesController < ApplicationController
  skip_before_filter :ocultar_degree_selected
  skip_before_filter :ocultar_year_selected
  before_filter :require_administrator, :except=>[:index, :show]
  # GET /signatures
  # GET /signatures.xml
  def index
    if current_user.is_a? Administrator
      @signatures = @degree_selected.signatures
    elsif current_user.is_a? Teacher
      @signatures = current_user.find_signatures(@year_selected.id, @degree_selected.id)
    else
      @signatures = current_user.find_signatures(@year_selected.id)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @signatures }
    end
  end

  # GET /signatures/1
  # GET /signatures/1.xml
  def show
    if current_user.is_a? Administrator
      @signature = Signature.find(params[:id])
    elsif current_user.is_a? Teacher
      @signature = current_user.find_signature(params[:id], @year_selected.id, @degree_selected.id)
    else
      @signature = current_user.find_signature(params[:id], @year_selected.id)
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @signature }
    end
  end

  # GET /signatures/new
  # GET /signatures/new.xml
  def new
    @signature = Signature.new
    @signature.degree = @degree_selected

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @signature }
    end
  end

  # GET /signatures/1/edit
  def edit
    @signature = Signature.find(params[:id])
  end

  # POST /signatures
  # POST /signatures.xml
  def create
    @signature = Signature.new(params[:signature])

    respond_to do |format|
      if @signature.save
        format.html { redirect_to(@signature, :notice => 'La asignatura se ha creado correctamente.') }
        format.xml  { render :xml => @signature, :status => :created, :location => @signature }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @signature.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /signatures/1
  # PUT /signatures/1.xml
  def update
    @signature = Signature.find(params[:id])

    respond_to do |format|
      if @signature.update_attributes(params[:signature])
        format.html { redirect_to(@signature, :notice => 'La asignatura se modifico correctamente.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @signature.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /signatures/1
  # DELETE /signatures/1.xml
  def destroy
    @signature = Signature.find(params[:id])
    @signature.destroy rescue flash[:notice] = 'No se puede borrar la asignatura'

    respond_to do |format|
      format.html { redirect_to(signatures_url) }
      format.xml  { head :ok }
    end
  end

  # POST /signatures/create_student/1
  # POST /signatures/create_student/1.xml
  def create_student
    @signature = Signature.find(params[:id])
    @signatures_student = @signature.signatures_students.build(params[:signatures_student])

    respond_to do |format|
      if @signatures_student.save
        format.html { redirect_to(@signature, :notice => 'Alumno matriculado con éxito.') }
        format.xml  { render :xml => @signature, :status => :created, :location => @signature }
      else
        format.html { render :action => "show" }
        format.xml  { render :xml => @signature.errors, :status => :unprocessable_entity }
      end
    end
  end

  # POST /signatures/create_teacher/1
  # POST /signatures/create_teacher/1.xml
  def create_teacher
    @signature = Signature.find(params[:id])
    @signatures_teacher = @signature.signatures_teachers.build(params[:signatures_teacher])

    respond_to do |format|
      if @signatures_teacher.save
        format.html { redirect_to(@signature, :notice => 'Profesor añadido con éxito.') }
        format.xml  { render :xml => @signature, :status => :created, :location => @signature }
      else
        format.html { render :action => "show" }
        format.xml  { render :xml => @signature.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /signatures/destroy_teacher/1
  # DELETE /signatures/destroy_teacher/1.xml
  def destroy_teacher
    @signature = Signature.find(params[:id])
    @signature_teacher = @signature.signatures_teachers.find(:first,
      :conditions=>['year_id=? AND teacher_id=?', params[:year_id], params[:teacher_id]])
    @signature_teacher.destroy #rescue flash[:notice] = 'No se puede borrar al profesor de esta asignatura'

    respond_to do |format|
      format.html { redirect_to(@signature) }
      format.xml  { head :ok }
    end
  end

  # DELETE /signatures/destroy_student/1
  # DELETE /signatures/destroy_student/1.xml
  def destroy_student
    @signature = Signature.find(params[:id])
    @signature_student = @signature.signatures_students.find(:first,
      :conditions=>['year_id=? AND student_id=?', params[:year_id], params[:student_id]])
    @signature_student.destroy rescue flash[:notice] = 'No se puede borrar al alumno de esta asignatura'

    respond_to do |format|
      format.html { redirect_to(@signature) }
      format.xml  { head :ok }
    end
  end
 
end
