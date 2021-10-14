require 'rubygems'
require 'nokogiri'
require 'open-uri' 

page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))

def get_townhall_email(pages)
  city_name = pages.xpath('//main//h1').text.split(" ")
  hash_one_city = {city_name[0] => pages.xpath('/html/body/div[1]/main/section[2]/div/table/tbody/tr[4]/td[2]').text}
end

def get_townhall_urls(page)
  links_mairie = page.xpath('//a[@class="lientxt"]')

  links_mairie_array = []
  links_mairie.each do |link|
    links_mairie_array << "https://annuaire-des-mairies.com" + link['href'].delete_prefix(".")
  end
  return links_mairie_array
end

def perform(page)
  result = []
  get_townhall_urls(page).each do |url|
    pages = Nokogiri::HTML(URI.open(url))
    result << get_townhall_email(pages)
  end
  return result
end