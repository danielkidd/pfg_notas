# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem

  before_filter :require_logged

  before_filter :find_year
  before_filter :find_degree

  layout 'application'

protected
  def require_logged
    unless logged_in?
      flash[:error] = 'Acceso no permitido: Debe identificarse.'
      redirect_to '/login'
    end
  end

  def require_administrator
    unless current_user.is_a? Administrator
      flash[:error] = 'Acceso no permitido.'
      redirect_to '/'
    else
      @administrator = current_user
    end
  end
  alias :require_administrator2 :require_administrator

  def require_teacher
    unless current_user.is_a? Teacher
      flash[:error] = 'Acceso no permitido.'
      redirect_to '/'
    else
      @teacher = current_user
    end
  end

  def require_student
    unless current_user.is_a? Student
      flash[:error] = 'Acceso no permitido.'
      redirect_to '/'
    else
      @student = current_user
    end
  end

  def require_administrator_or_teacher
    if current_user.is_a? Administrator
      @administrator = current_user
    elsif current_user.is_a? Teacher
      @teacher = current_user
    else
      flash[:error] = 'Acceso no permitido.'
      redirect_to '/'
    end
  end
  alias :require_administrator_or_teacher2 :require_administrator_or_teacher

  def require_administrator_or_student
    if current_user.is_a? Administrator
      @administrator = current_user
    elsif current_user.is_a? Student
      @student = current_user
    else
      flash[:error] = 'Acceso no permitido.'
      redirect_to '/'
    end
  end

  def is_self
    User.find(params[:id]) == current_user
  end

  def find_year
    @current_year = Year.current
    @year_selected = session[:year_selected] || @current_year
  end

  def find_degree
    unless current_user.is_a? Student
      @degree_selected = session[:degree_selected] || Degree.find(:first)
      unless @degree_selected.present?
        flash[:notice] = 'Debe crear al menos una titulación'
        redirect_to new_degree_path
      end
    end
  end
  
  def ocultar_year_selected
    @ocultar_year_selected = true
  end
  
  def ocultar_degree_selected
    @ocultar_degree_selected = true
  end

  def calcula_migas_part
    @migas = []
    @migas << { signature_part_path(@signature, @part) => @part.description } unless @part.blank?
    p = @parent
    while p.present? do
      @migas << { signature_part_path(@signature, p) => p.description }
      p = p.parent
    end
    @migas << { signature_path(@signature) => @signature.name } unless @signature.blank?
  end

end
