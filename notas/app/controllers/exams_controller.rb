class ExamsController < ApplicationController
  before_filter :require_teacher
  before_filter :find_signature_and_part
  before_filter :ocultar_year_selected
  before_filter :ocultar_degree_selected
  before_filter :calcula_migas_part

  # GET /exams
  # GET /exams.xml
  def index
    @exams = @part.exams.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @exams }
    end
  end

  # GET /exams/1
  # GET /exams/1.xml
  def show
    @exam = @part.exams.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @exam }
    end
  end

  # GET /exams/new
  # GET /exams/new.xml
  def new
    @exam = @part.exams.build
    @exam.new_signatures_students.each do |signatures_student|
      @exam.evaluations.build(:signatures_student=>signatures_student)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @exam }
    end
  end

  # GET /exams/1/edit
  def edit
    @exam = @part.exams.find(params[:id])
  end

  # POST /exams
  # POST /exams.xml
  def create
    @exam = Exam.new(params[:exam])

    respond_to do |format|
      if @exam.save
        format.html { redirect_to(signature_part_exam_url(@signature, @part, @exam), :notice => 'El examen se creo correctamente.') }
        format.xml  { render :xml => @exam, :status => :created, :location => @exam }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /exams/1
  # PUT /exams/1.xml
  def update
    @exam = Exam.find(params[:id])

    respond_to do |format|
      if @exam.update_attributes(params[:exam])
        format.html { redirect_to(signature_part_exam_url(@signature, @part, @exam), :notice => 'El examen se modifico correctamente..') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /exams/1
  # DELETE /exams/1.xml
  def destroy
    @exam = Exam.find(params[:id])
    @exam.destroy rescue flash[:notice] = 'No se puede borrar el examen'

    respond_to do |format|
      format.html { redirect_to(signature_part_exams_url(@signature, @part)) }
      format.xml  { head :ok }
    end
  end

protected
  def find_signature_and_part
    @signature = Signature.find params[:signature_id]
    @part = @signature.parts.find params[:part_id], :conditions=>{:year_id=>@year_selected}
    @ordinary = @part.ordinary
    @parent = @part.parent
  end
end
