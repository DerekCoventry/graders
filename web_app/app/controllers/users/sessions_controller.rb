class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def auth()
    include "open-uri"
    agent = Mechanize.new
    charPeriod = 0
    charAt = 0
    while current[charPeriod] != '.'
      charPeriod += 1
    end
    while current[charAt+charPeriod] != '@'
      charAt += 1
    end
    buckid= self.email[0,charPeriod]+current[charPeriod,charAt]
    page = ("directory.osu.edu/fpxml.php?name_n="+buckid)
    doc = Nokogiri::HTML(open(page.uri.to_s))
    perm = doc.xpath('//affiliation')
    puts perm
    if perm == "Staff Employee"
      self.staff = true
    elsif perm == "Faculty Employee"
      self.professor = true
    end
    self.save
  end
end
