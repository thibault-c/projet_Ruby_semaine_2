require 'rubygems'
require 'nokogiri' 
require 'open-uri'

 

def get_all_the_urls_of_val_doise_townhalls()
	page = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com/val-d-oise.html"))

	mail_townhall = Hash.new(0)
	#@mail_townhall = mail_townhall

	news_links = page.css("a.lientxt")
	news_links.each  { |link| 
		a = link['href']
		b = a.gsub(/\.{0}/,"") #enlève le . au début de l'url de chaque page
		#puts a
		#puts b
		url_townhall_unique = "http://www.annuaire-des-mairies.com#{b}" # écrit l'url complète de chaque page de mairie avec le préfixe complet http://www. etc
		
		#puts url_townhall_unique
		mailmairie = get_the_email_of_a_townhal_from_its_webpage(url_townhall_unique)
		mail_townhall[link.text] = mailmairie

		}

	puts mail_townhall

end

=begin
def get_the_email_of_a_townhal_from_its_webpage(url)

	page = Nokogiri::HTML(open(url))
	email = page.css("p.Style22")
	email.each { |mail| 
		email_townhall = /\A[^@\s]+@[^@\s]+\z/.match(mail) 
		a = email_townhall.text
		puts a
	}
=end

def get_the_email_of_a_townhal_from_its_webpage(url)
	page = Nokogiri::HTML(open(url))
	email = page.css(".style27 .Style22")
	mailmairie = email[5].text
	return mailmairie
end


get_all_the_urls_of_val_doise_townhalls()


