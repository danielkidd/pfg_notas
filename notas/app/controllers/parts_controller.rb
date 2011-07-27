class PartsController < ApplicationController
  before_filter :require_teacher
  before_filter :find_signature_and_ordinary
  before_filter :ocultar_year_selected
  before_filter :ocultar_degree_selected
  before_filter :calcula_migas_part

  # GET /parts
  # GET /parts.xml
  def index
    @parts = @signature.parts.all :conditions=>{
        :ordinary=>@ordinary,
        :parent_id=>@parent,
        :year_id=>@year_selected
      }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @parts }
    end
  end

  # GET /parts/1
  # GET /parts/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @part }
    end
  end

  # GET /parts/new
  # GET /parts/new.xml
  def new
    @part = @signature.parts.build(:ordinary=>@ordinary, :year=>@year_selected,
      :parent_id=>(@parent ? @parent.id : nil))

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @part }
    end
  end

  # GET /parts/1/edit
  def edit
  end

  # POST /parts
  # POST /parts.xml
  def create
    @part = Part.new(params[:part])

    respond_to do |format|
      if @part.save
        format.html { redirect_to(signature_part_path(@signature, @part), :notice => 'Bloque creado con éxito.') }
        format.xml  { render :xml => @part, :status => :created, :location => @part }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @part.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /parts/1
  # PUT /parts/1.xml
  def update
    respond_to do |format|
      if @part.update_attributes(params[:part])
        format.html { redirect_to(signature_part_path(@signature, @part), :notice => 'Bloque actualizado con éxito.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @part.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /parts/1
  # DELETE /parts/1.xml
  def destroy
    @part.destroy rescue flash[:notice] = 'No se puede borrar el bloque'

    respond_to do |format|
      format.html { redirect_to(signature_parts_url(@signature, :ordinary=>@ordinary, :parent_id=>@parent)) }
      format.xml  { head :ok }
    end
  end

protected
  def find_signature_and_ordinary
    @signature = Signature.find params[:signature_id]
    if params[:id].present?
      @part = @signature.parts.find params[:id], :conditions=>{:year_id=>@year_selected}
      @ordinary = @part.ordinary
      @parent = @part.parent
    else
      @ordinary = params[:ordinary] ? true : false
      @parent = params[:parent_id] ? @signature.parts.find(params[:parent_id],
        :conditions=>{:ordinary=>@ordinary}) : nil
    end
  end
end
