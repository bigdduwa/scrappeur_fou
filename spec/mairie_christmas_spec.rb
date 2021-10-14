require_relative '../lib/mairie_christmas'
require 'nokogiri'
require 'open-uri' 
page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))

describe "mairie christmas" do
  it "should not return nil" do
    expect(perform(page)).not_to be_nil
  end

  it "should return an array of 185 values" do
    expect(perform(page).length).to be == 185
  end

  it "should contain Cergy" do
    expect(perform(page).any? {|hash| hash.key?("CERGY")}).to eq (true)
  end
end