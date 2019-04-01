require 'webdrivers'
require 'watir'

browser = Watir::Browser.new :firefox
browser.goto 'https://www.firmy.cz/Restauracni-a-pohostinske-sluzby?page=132'
loop do
    browser.h3.wait_until(&:present?)
    titles = browser.h3s
    titles.each do |title|
        link = browser.a(text: title.text).href
        puts "Adding url to file"
        File.open('urls.csv', 'a'){|file| file.write("#{link}\n")}
    end
    nxt = browser.a(id: "nextBtn")
    nxt.wait_until(&:present?)
    if nxt.present?
     puts "waiting..."        
     #sleep rand(10..180)
     puts "going next page"
     nxt.click
    else
      break
    end  
end