class AuthenticateController < ApplicationController
  def index
    current_user.auth()
    if current_user.staff || current_user.professor
      redirect_to "/"
    end
  end
  def confirm
  	@professors = Directory.all.each do |d| 
  		if d.professor 
  		 d 
  		end
  	end
  end
  def staff
  	@staff = Directory.all.each do |d| 
  		if d.staff 
  		 d 
  		end
  	end
  end
  def email
  end
end
