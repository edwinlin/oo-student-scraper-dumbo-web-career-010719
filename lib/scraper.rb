require 'open-uri'
require 'pry'

class Scraper
	# def students
	# 	@students
	# end

  def self.scrape_index_page(index_url)

    html = File.read(index_url)
    scrape = Nokogiri::HTML(html)

	result = scrape.css("div.student-card").map do |post|
		{:name => post.css("h4.student-name").text, :location => post.css("p.student-location").text, :profile_url => post.css("a")[0]["href"]}
	end
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    scrape = Nokogiri::HTML(html)

    student = {}
    social = ["facebook", "twitter", "linkedin", "github"]

	scrape.css("div.social-icon-container>a").each_with_index do |post, idx|
		if social.include?(post["href"].sub(/^https?\:\/\/(www.)?/,'').split(".com")[0])
			symbol = post["href"].sub(/^https?\:\/\/(www.)?/,'').split(".com")[0].to_sym
		else
			symbol = "blog".to_sym
		end
			
		student[symbol] = post["href"]
	end
		student[:profile_quote] = scrape.css(".vitals-text-container").css(".profile-quote").text
		student[:bio] = scrape.css("div.details-container").css(".description-holder p").text

		return student
  end

end

