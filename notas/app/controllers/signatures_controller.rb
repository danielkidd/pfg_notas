class SignaturesController < ApplicationController
  before_filter :require_administrator, :except=>[:index, :show]
  # GET /signatures
  # GET /signatures.xml
  def index
    if current_user.is_a? Administrator
      @signatures = Signature.all
    elsif current_user.is_a? Teacher
      @signatures = current_user.signatures(:conditions=>['year_id = ?', Year.current.id])
    elsif current_user.is_a? Student
      @signatures = current_user.signatures(:conditions=>['year_id = ?', Year.current.id])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @signatures }
    end
  end

  # GET /signatures/1
  # GET /signatures/1.xml
  def show
    @signature = Signature.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @signature }
    end
  end

  # GET /signatures/new
  # GET /signatures/new.xml
  def new
    @signature = Signature.new

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
    params[:signature][:teacher_ids] ||= []
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
    @signature.destroy

    respond_to do |format|
      format.html { redirect_to(signatures_url) }
      format.xml  { head :ok }
    end
  end

  # POST /create_student/1
  # POST /create_student/1.xml
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

end
