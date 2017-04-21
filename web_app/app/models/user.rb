class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :schedule
  #def find_user(emailCheck)
  #	where('email == ?' emailCheck)
  #end
  def auth_professor(professors)
    #@user_cur = User.find_user(emailCheckit.to_s)
    #@user_cur.each |s| 
    #  x = s.id 
    #end
    #cur = User.find x 
    if Directory.exists? self.email.to_s then
      found = Directory.find self.email.to_s
      if found.professor then
        self.professor = true
        self.save
      end
    end

  end
  def auth_staff(staff)
    #@user_cur = User.find_user(emailCheckit.to_s)
    #@user_cur.each |s| 
    #  x = s.id 
    #end
    #cur = User.find x 
    if Directory.exists? self.email.to_s then
      found = Directory.find self.email.to_s
      if found.staff then
        self.staff = true
        self.save
      end
    end
  end
end
