class HomeController < ApplicationController
  def index
    respond_to do |format|
      if current_user.is_a? Administrator
        format.html { redirect_to(teachers_url) } # provisional
      elsif current_user.is_a? Teacher
        format.html { redirect_to(signatures_url) } # provisional
      elsif current_user.is_a? Student
        format.html { redirect_to(signatures_url) } # provisional
      else
        format.html { redirect_to('/login') }
      end
    end
  end

  def change_year
    @year_selected = session[:year_selected] = Year.find(params[:id])
    index
  end

end
