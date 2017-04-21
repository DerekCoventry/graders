class AuthenticateController < ApplicationController
  def index
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
