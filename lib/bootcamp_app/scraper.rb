require 'pry'
class BootcampApp::Scraper #class responsible for all scraping logic

    def self.scrape
        doc = Nokogiri::HTML(open("https://www.coursereport.com/best-coding-bootcamps")) 
        doc.css("div.info-container").each do |bootcamp|
            name = bootcamp.css("h3").children[0].text.gsub(/\d+/,"").delete(" . ").gsub(/(?<=[A-Za-z])(?=[A-Z])/, ' ')
            locations = bootcamp.css(".location").text
            overall_rating = bootcamp.css(".longform-rating-text").children[0].text
            # about = bootcamp.css(".desc-container").css("p").children[0].text
            url_link = bootcamp.css("h3").css("a").attr('href')
            BootcampApp::Bootcamp.new(name, locations, overall_rating, url_link)
        end
    end


    def self.scrape_two(bootcamp)
        base_url = "https://www.coursereport.com"
        doc = open("#{base_url}" + "#{bootcamp.url_link}")
        html_elements = Nokogiri::HTML(doc)
        bootcamp.info = html_elements.css("div.read-more").css("p").children[0]
        bootcamp.review = html_elements.css("div.content").css(".read-more").children[0]


    end
end
