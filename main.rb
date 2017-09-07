require './services/page_handler'
require './dao/yaml_dao'
require './dao/csv_dao'

puts "Programm started"
yaml_dao = YamlDAO.new
url = yaml_dao.get_url
exit_file_name = yaml_dao.get_exit_file_name

puts "Start searching in #{url}"

handler = PageHandler.new
links_array = []
handler.get_all_links(url, links_array)

multi_page_links = []
links_array.each do |link| # add each
	puts "Getting links from - " + link.to_s
	handler.find_multi_links(link, multi_page_links)
end

print "Getting information from pages"
inform = []
multi_page_links.each do |url| # ad each
	handler.search_info(url, inform)
	print "."
end

CsvDAO.new .save_result(inform, exit_file_name)

puts "Done"