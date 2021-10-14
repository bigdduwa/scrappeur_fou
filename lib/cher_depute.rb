require 'rubygems'
require 'nokogiri'
require 'open-uri' 

page = Nokogiri::HTML(URI.open("https://www2.assemblee-nationale.fr/deputes/liste/tableau"))

def get_one_depute(pages)
    array_depute_name = pages.xpath('//*[@id="haut-contenu-page"]/article/div[2]/h1').text.split(" ")
    hash_one_depute = {'first_name' => array_depute_name[1],'last_name' => array_depute_name[2], 'email' => pages.xpath('//*[@id="haut-contenu-page"]/article/div[3]/div/dl/dd[4]/ul/li[2]/a').text}
return hash_one_depute
end 

def get_depute_url(page)
    links_depute = page.xpath('//tbody//a')
    links_depute_array = []
    links_depute.each do |link|
        links_depute_array << 'https://www2.assemblee-nationale.fr' + link['href']   
    end 
    return links_depute_array
end 

def perform(page)
    result = []
    get_depute_url(page).each do |url|
        pages = Nokogiri::HTML(URI.open(url))
        result << get_one_depute(pages)
    end 
    return result
end 

puts perform(page)




