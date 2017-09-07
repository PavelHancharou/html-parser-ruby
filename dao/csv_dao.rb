require 'csv'

class CsvDAO
	def save_result(inform, exit_file_name)
		CSV.open(exit_file_name, 'a') do |writer|
			for i in 0..(inform.size-1)
				writer << [inform[i][0], inform[i][1],inform[i][2] ]
				writer << [inform[i][1]]
				writer << [inform[i][2]]
			end
		end
	end
end