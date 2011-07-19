# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  before_filter :ocultar_degree_selected
  before_filter :ocultar_year_selected
  skip_before_filter :find_degree
  skip_before_filter :find_year
  skip_before_filter :require_logged

  # render new.erb.html
  def new
  end

  def create
    logout_keeping_session!
    user = User.authenticate(params[:login], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      redirect_back_or_default('/')
      flash[:notice] = "Identificado con éxito"
    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = "Sesión cerrada."
    redirect_back_or_default('/')
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Datos de acceso incorrectos para '#{params[:login]}'"
    logger.warn "Fallo para '#{params[:login]}' desde #{request.remote_ip} a la hora: #{Time.now.utc}"
  end
end
