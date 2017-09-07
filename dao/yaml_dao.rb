require 'yaml'

class YamlDAO
	def get_url
		YAML.load(File.read(File.expand_path('../../config.yaml', __FILE__))) [:url]
	end

	def get_exit_file_name
		YAML.load(File.read(File.expand_path('../../config.yaml', __FILE__))) [:exit_file_name]
	end
end