#Program that aims to take every each minutes the last update value of a crypto currency.

require 'rubygems'
require 'nokogiri' 
require 'open-uri'

doc = Nokogiri::HTML(open("https://coinmarketcap.com/currencies/"))

def main(doc)

	stockmarket_crypto_currency = Hash.new(0)

	page = doc.css('a.price')

	page.each  { |i| 
		 hyperlink_currency_value = i['href']
		 #puts hyperlink_currency_value
		 hyperlink_currency_value_full = "https://coinmarketcap.com" + hyperlink_currency_value
		 #puts hyperlink_currency_value_full
		 get_currency_name_and_value(hyperlink_currency_value_full)
		 

		 stockmarket_crypto_currency[@currency_name] = @currency_value
	}

	puts stockmarket_crypto_currency

end


def get_currency_name_and_value(url)

	currency = Nokogiri::HTML(open(url))

	quote_price = currency.css('span#quote_price')

	currency_value = quote_price.text

	text = currency.css('h1.text-large')

	currency_name = text.text

	@currency_name = currency_name
	@currency_value = currency_value

end

def currency_update(doc)

	t1 = Time.now
	puts 't1 = ' + t1.to_s
	t1 = t1 + 5

	while t1 do
		
		if t1 == Time.now or t1 < Time.now
			t1 = t1 + 60
			puts 't1_update = ' + t1.to_s
			puts main(doc)
			
		end

	end

end


puts currency_update(doc)
