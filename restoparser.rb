require 'webdrivers'
require 'watir'

puts "Loading links"
input = File.read('urls.csv')
links = input.split("\n").slice(52,99)
puts "#{links.count} links loaded"

browser = Watir::Browser.new :firefox

links.each do |link|

    browser.goto link
    browser.ul(class: "baseCategoriesUl").wait_until(&:present?)

    name = browser.h1(itemprop: "name").text
    adress = browser.h2(class: "sAddress").text
    website = browser.a(id: "companyUrl").text
    email = browser.a(class: "companyMail").text if browser.a(class: "companyMail").present?
    description = browser.p(class: "description").text
    phones =  []
    browser.divs(class: "tel").each{|tel| phones << tel.text}
    subcats = browser.ul(class: "baseCategoriesUl").text.split("\n").join(",")
    
    puts "Writing to the file"

    File.open('output.csv', 'a'){|file| file.write("#{name};#{adress};#{website};#{email};#{description};#{phones.join(",")};#{subcats}\n")}


end

