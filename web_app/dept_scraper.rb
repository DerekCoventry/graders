require "Mechanize"
require "nokogiri"
require "open-uri"



agent = Mechanize.new
staffpage = agent.get("https://cse.osu.edu/directory")
doc = Nokogiri::HTML(open(staffpage.uri.to_s))
selects = doc.xpath("//span//a")
for i in 0...selects.length
	current = selects[i].to_s
	charCount = 0
	while current[charCount+16] != '"'
		charCount += 1
	end
	puts current[16, charCount]
	
end

staffpage2 = agent.get("https://cse.osu.edu/about-us/staff")
doc2 = Nokogiri::HTML(open(staffpage2.uri.to_s))
selects2 = doc2.xpath("//span//a")
for i in 0...selects2.length
	current = selects[i].to_s
	charCount = 0
	while current[charCount+16] != '"'
		charCount += 1
	end
	puts current[16, charCount]
	
end

staffpage2 = agent.get("https://cse.osu.edu/about-us/faculty")
doc2 = Nokogiri::HTML(open(staffpage2.uri.to_s))
selects2 = doc2.xpath("//span//a")
for i in 0...selects2.length
	current = selects[i].to_s
	charCount = 0
	while current[charCount+16] != '"'
		charCount += 1
	end
	puts current[16, charCount]
	
end