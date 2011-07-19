class DegreesController < ApplicationController
  before_filter :ocultar_degree_selected
  before_filter :ocultar_year_selected
  skip_before_filter :find_degree
  skip_before_filter :find_year
  before_filter :require_administrator

  # GET /degrees
  # GET /degrees.xml
  def index
    @degrees = Degree.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @degrees }
    end
  end

  # GET /degrees/1
  # GET /degrees/1.xml
  def show
    @degree = Degree.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @degree }
    end
  end

  # GET /degrees/new
  # GET /degrees/new.xml
  def new
    @degree = Degree.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @degree }
    end
  end

  # GET /degrees/1/edit
  def edit
    @degree = Degree.find(params[:id])
  end

  # POST /degrees
  # POST /degrees.xml
  def create
    @degree = Degree.new(params[:degree])

    respond_to do |format|
      if @degree.save
        format.html { redirect_to(@degree, :notice => 'La titulacion se ha creado correctamente.') }
        format.xml  { render :xml => @degree, :status => :created, :location => @degree }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @degree.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /degrees/1
  # PUT /degrees/1.xml
  def update
    @degree = Degree.find(params[:id])

    respond_to do |format|
      if @degree.update_attributes(params[:degree])
        format.html { redirect_to(@degree, :notice => 'La titulacion se modifico correctamente.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @degree.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /degrees/1
  # DELETE /degrees/1.xml
  def destroy
    @degree = Degree.find(params[:id])
    @degree.destroy rescue flash[:notice] = 'No se puede borrar la titulacion'

    respond_to do |format|
      format.html { redirect_to(degrees_url) }
      format.xml  { head :ok }
    end
  end
end
