require 'rubygems'
require 'nokogiri'
require 'open-uri' 

page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))

def fetching_names(page)
  crypto_names = page.xpath('//td[@class="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--hide-sm cmc-table__cell--sort-by__symbol"]/div')

  crypto_names_array = []

  crypto_names.each do |crypto_name|
    crypto_names_array << crypto_name.text
  end
  return crypto_names_array
end

#####################################

def fetching_prices(page)
  crypto_prices = page.xpath('//td[@class="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price"]/div')

  crypto_prices_array = []
  crypto_prices.each do |crypto_price|
    crypto_prices_array << crypto_price.text.delete("$,").to_f
  end
return crypto_prices_array
end

###################################
def array_of_hashes(crypto_names_array, crypto_prices_array)
  ar = []
  crypto_prices_array.length.times do |i|
    ar << {crypto_names_array[i] => crypto_prices_array[i]}
  end
  return ar
end
# puts my_hash=crypto_names_array.zip(crypto_prices_array).to_h

def perform(page)
  fetching_names(page)
  fetching_prices(page)
  puts array_of_hashes(fetching_names(page),fetching_prices(page))
end
perform(page)