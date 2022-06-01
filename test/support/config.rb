require 'yaml'
require 'erb'
require 'fileutils'
require 'pathname'

module ARTest
  class << self
    def config
      @config ||= read_config
    end

    private

    def config_file
      Pathname.new(ENV['ARCONFIG'] || TEST_ROOT + '/config.yml')
    end

    def read_config
      erb = ERB.new(config_file.read)
      expand_config(YAML.parse(erb.result(binding)).transform)
    end

    def expand_config(config)
      config['connections'].each do |adapter, connection|
        dbs = [['arunit', 'activerecord_unittest'], ['arunit2', 'activerecord_unittest2']]
        dbs.each do |name, db_name|
          unless connection[name].is_a?(Hash)
            connection[name] = { 'database' => connection[name] }
          end

          connection[name]['database'] ||= db_name
          connection[name]['adapter']  ||= adapter
        end
      end

      config
    end
  end
end
