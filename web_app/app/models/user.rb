class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :schedule
  #def find_user(emailCheck)
  #	where('email == ?' emailCheck)
  #end
  def auth()
    #@user_cur = User.find_user(emailCheckit.to_s)
    #@user_cur.each |s| 
    #  x = s.id 
    #end
    #cur = User.find x 
    if 
    ['agrawal.28@osu.edu', 'arora.9@osu.edu', 'babic.1@osu.edu', 'bair.41@osu.edu', 'baxter.95@osu.edu', 'belkin.8@osu.edu', 'bihari.5@osu.edu', 'blanas.2@osu.edu', 'boggus.2@osu.edu', 'bond.213@osu.edu', 'boxwell.1@osu.edu', 'bucci.2@osu.edu', 'chaabouni.1@osu.edu', 'champion.17@osu.edu', 'chandrasekaran.1@osu.edu', 'cheng.1190@osu.edu', 'choi.1399@osu.edu', 'cline.4@osu.edu', 'close.2@osu.edu', 'collins.424@osu.edu', 'cramer.85@osu.edu', 'crawfis.3@osu.edu', 'crawford.491@osu.edu', 'davis.1719@osu.edu', 'dey.8@osu.edu', 'dohm.1@osu.edu', 'eden.40@osu.edu', 'farris.94@osu.edu', 'fosler-lussier.1@osu.edu', 'foulk.1@osu.edu', 'fritz.26@osu.edu', 'fuhry.4@osu.edu', 'giles.25@osu.edu', 'gomori.1@osu.edu', 'green.25@osu.edu', 'grimme.16@osu.edu', 'hamidouche.2@osu.edu', 'hamm.95@osu.edu', 'havard.2@osu.edu', 'heym.1@osu.edu', 'huang.468@osu.edu', 'ilin.1@osu.edu', 'jaber.3@osu.edu', 'jackson.2661@osu.edu', 'jacobs.968@osu.edu', 'jayanti.3@osu.edu', 'jones.5684@osu.edu', 'jones.5374@osu.edu', 'joseph.97@osu.edu', 'josephson.1@osu.edu', 'joshi.127@osu.edu', 'kerr.2@osu.edu', 'kiel.32@osu.edu', 'king.281@osu.edu', 'kneisly.2@osu.edu', 'knopp.16@osu.edu', 'krishnasamy.1@osu.edu', 'lai.187@osu.edu', 'lai.1@osu.edu', 'lee.2272@osu.edu', 'li.961@osu.edu', 'liu.1@osu.edu', 'long.19@osu.edu', 'lu.932@osu.edu', 'lyons.220@osu.edu', 'machiraju.1@osu.edu', 'madrid.1@osu.edu', 'mallon.3@osu.edu', 'mamrak.1@osu.edu', 'martin.2513@osu.edu', 'mcgough.22@osu.edu', 'mckinley.217@osu.edu', 'memolitechera.1@osu.edu', 'michel.5@osu.edu', 'mills.680@osu.edu', 'mirzaei.4@osu.edu', 'morris.343@osu.edu', 'muller.3@osu.edu', 'nandi.9@osu.edu', 'narasimhan.2@osu.edu', 'nivar.1@osu.edu', 'ogden.2@osu.edu', 'omidvar-tehrani.1@osu.edu', 'panda.2@osu.edu', 'parent.1@osu.edu', 'parthasarathy.2@osu.edu', 'peng.377@osu.edu', 'petrarca.1@osu.edu', 'qin.34@osu.edu', 'ramasamy.12@osu.edu', 'ramnath.6@osu.edu', 'randels.1@osu.edu', 'reeves.92@osu.edu', 'rice.134@osu.edu', 'ritter.1492@osu.edu', 'rivera.395@osu.edu', 'roman.45@osu.edu', 'romig.1@osu.edu', 'rountev.1@osu.edu', 'sadayappan.1@osu.edu', 'shareef.1@osu.edu', 'shen.94@osu.edu', 'shroff.11@osu.edu', 'sidiropoulos.1@osu.edu', 'sinha.43@osu.edu', 'sivilotti.1@osu.edu', 'smith.11681@osu.edu', 'soundarajan.1@osu.edu', 'spehr.4@osu.edu', 'srinivasan.115@osu.edu', 'stewart.962@osu.edu', 'strader.1@osu.edu', 'subramoni.1@osu.edu', 'sun.397@osu.edu', 'supowit.1@osu.edu', 'suresh.86@osu.edu', 'teodorescu.1@osu.edu', 'vanhulse.1@osu.edu', 'wade.230@osu.edu', 'wang.77@osu.edu', 'wang.3602@osu.edu', 'wang.3596@osu.edu', 'wang.7564@osu.edu', 'wang.1016@osu.edu', 'weide.1@osu.edu', 'welch.162@osu.edu', 'wenger.4@osu.edu', 'wolf.332@osu.edu', 'xia.52@osu.edu', 'xu.1265@osu.edu', 'xuan.3@osu.edu', 'yandrich.4@osu.edu', 'yilmaz.15@osu.edu', 'zaccai.1@osu.edu', 'zhang.574@osu.edu', 'zhang.8151@osu.edu', 'zhang.834@osu.edu', 'ziniel.1@osu.edu', 
      'zweben.1@osu.edu'].include? self.email.to_s then
      self.professor = true 
    end
    self.save
  end
end
