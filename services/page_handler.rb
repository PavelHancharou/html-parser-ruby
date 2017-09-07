require 'open-uri'
require 'nokogiri'

class PageHandler
	def search_info(url, inform)
		doc = Nokogiri::HTML(open(url))
		header_xpath = ".//*[@id='right']//h1"
		header = doc.xpath(header_xpath).text

		weight_xpath = ".//*[@id='attributes']//*[@class='attribute_name']"
		weight = []
		doc.xpath(weight_xpath).each do |w|
			weight << w.text
		end

		price = []
		price_xpath = ".//*[@id='attributes']//span[@class='attribute_price']"
		doc.xpath(price_xpath).each do |p|
			price << p.text.to_s[1..-3]
		end

		img = []
		img_xpath = ".//*[@id='thumbs_list_frame']//img"
		doc.xpath(img_xpath).each do |i|
			img << i.attr('src').to_s
		end

		for i in 0..(weight.size-1)
			inform.push(
				[header.to_s + " - " + weight[i].to_s, price[i], img[i]]
			)
		end
		weight.clear
		price.clear
		img.clear
	end

	def get_all_links(url, links_array)
		currect_url = open(url).base_uri.to_s
		xpath = ".//*[@id='pagination_bottom']/ul/li[6]/a/span"
		last_page_num = find_xpath(url, xpath).text.to_i

		links_array.push(
			currect_url
		)

		for i in 2..last_page_num
			links_array.push(
				currect_url + "?p=" + i.to_s
			)
		end
	end

	def find_multi_links(url, result_array)
		xpath = ".//*[@id='center_column']//*[@class='product-name']"

		find_xpath(url, xpath).each do |link|
			name = link.attr('href')
			result_array.push(
				name
			)
		end
	end

	def find_xpath(url, xpath)
		Nokogiri::HTML(open(url)).xpath(xpath)
	end
end
