require_relative '../lib/dark_trader'
require 'nokogiri'
require 'open-uri' 

page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))

describe "crypto scrapper" do
  it "should return an array with no nil values" do
    expect(crypto_scrapper(page)).not_to be_nil
  end

  it "should return an array of at least 20 values" do
    expect(crypto_scrapper(page).length).to be >= 20
  end

  it "should return Bitcoin" do
    expect(crypto_scrapper(page).any? {|hash| hash.key?("BTC")}).to eq (true)
  end

  it "should return Ethereum" do
    expect(crypto_scrapper(page).any? {|hash| hash.key?("ETH")}).to eq (true)
  end

  it "should return Dogecoin" do
    expect(crypto_scrapper(page).any? {|hash| hash.key?("DOGE")}).to eq (true)
  end
end