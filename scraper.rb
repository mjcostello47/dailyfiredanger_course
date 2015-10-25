# This is a template for a Ruby scraper on morph.io (https://morph.io)
# including some code snippets below that you should find helpful

require 'scraperwiki'
require 'mechanize'
#
agent = Mechanize.new
#
# # Read in a page
page = agent.get("http://www.rfs.nsw.gov.au/feeds/fdrToban.xml")
#
# # Find someThing on the page using css selectors

districts = page.search('District')

districts.each do |district|
	name = district.at('Name').text
	
	if district.at('Councils')
		councils = district.at('Councils').text
	else
		councils = ""
	end
	
	if district.at('DangerLevelToday')
		dangertoday = district.at('DangerLevelToday').text
	else
		dantertoday = ""
	end
	
	if district.at('DangerLevelTomorrow')
		dangertomorrow = district.at('DangerLevelTomorrow').text
	else
		dangertomorrow = ""
	end
	
	firebantoday =  district.at('FireBanToday').text
	
	firebantomorrow =  district.at('FireBanTomorrow').text
	
	record = {
		date: Date.today,
		name: name,
		councils: councils,
		dangertoday: dangertoday,
		dangertomorrow: dangertomorrow,
		firebantoday: firebantoday,
		firebantomorrow: firebantomorrow}

puts record

	
	ScraperWiki.save_sqlite([:name, :date], record)

end

#
# # Write out to the sqlite database using scraperwiki library
# ScraperWiki.save_sqlite(["name"], {"name" => "susan", "occupation" => "software developer"})
#
# # An arbitrary query against the database
# ScraperWiki.select("* from data where 'name'='peter'")

# You don't have to do things with the Mechanize or ScraperWiki libraries.
# You can use whatever gems you want: https://morph.io/documentation/ruby
# All that matters is that your final data is written to an SQLite database
# called "data.sqlite" in the current working directory which has at least a table
# called "data".
