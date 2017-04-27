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
  def auth()
    em = self.email
    if em.include?  "@osu.edu"
      agent = Mechanize.new
      charPeriod = 0
      charAt = 0
      while em[charPeriod] != '.'
        charPeriod += 1
      end
      while em[charAt+charPeriod] != '@'
        charAt += 1
      end
      buckid= self.email[0,charPeriod]+self.email[charPeriod,charAt]
      puts buckid
      page = agent.get("http://directory.osu.edu/fpxml.php?name_n="+buckid)
      doc = Nokogiri::HTML(open(page.uri.to_s))
      perm = doc.xpath('//affiliation')
      puts perm
      if perm.to_s.include? "Staff"
        self.staff = true
      elsif perm.to_s.include? "Faculty"
        self.professor = true
      end
      self.save
    end
  end
end
