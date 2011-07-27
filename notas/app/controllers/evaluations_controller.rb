class EvaluationsController < ApplicationController
  before_filter :require_teacher
  before_filter :find_signature_and_exam
  before_filter :ocultar_year_selected
  before_filter :ocultar_degree_selected
  before_filter :calcula_migas_part

  # POST /evaluations
  # POST /evaluations.xml
  def create
    @evaluation = @exam.evaluations.build(params[:evaluation])

    respond_to do |format|
      if @evaluation.save
        format.html { redirect_to(signature_part_exam_url(@signature, @part, @exam), :notice => 'La nota se creo correctamente.') }
        format.xml  { render :xml => @evaluation, :status => :created, :location => @evaluation }
      else
        format.html { render 'exams/show' }
        format.xml  { render :xml => @evaluation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /evaluations
  # PUT /evaluations.xml
  def update
    @evaluation = @exam.evaluations.find(params[:id])

    respond_to do |format|
      if @evaluation.update_attributes(params[:evaluation])
        format.html { redirect_to(signature_part_exam_url(@signature, @part, @exam), :notice => 'La nota se actualizo correctamente.') }
        format.xml  { render :xml => @evaluation, :status => :created, :location => @evaluation }
      else
        format.html { render 'exams/show' }
        format.xml  { render :xml => @evaluation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /evaluations/1
  # DELETE /evaluations/1.xml
  def destroy
    @evaluation = @exam.evaluations.find(params[:id])
    @evaluation.destroy rescue flash[:notice] = 'No se puede borrar la nota'

    respond_to do |format|
      format.html { redirect_to(signature_part_exam_url(@signature, @part, @exam)) }
      format.xml  { head :ok }
    end
  end

protected
  def find_signature_and_exam
    @signature = Signature.find params[:signature_id]
    @part = @signature.parts.find params[:part_id], :conditions=>{:year_id=>@year_selected}
    @ordinary = @part.ordinary
    @parent = @part.parent
    @exam = @part.exams.find params[:exam_id]
  end
end
