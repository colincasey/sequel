require 'yaml'

module Sequel  
  def self.version
    @version ||= load_from_version_file
  end

  def self.load_from_version_file
    version_config = YAML.load_file(File.join(File.dirname(__FILE__), '..', '..', 'VERSION.yml'))
    major = version_config[:major]
    minor = version_config[:minor]
    patch = version_config[:patch]
    "#{major}.#{minor}.#{patch}"
  end
end
