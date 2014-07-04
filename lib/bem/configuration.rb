module BEM
  class Configuration
    attr_accessor :technologies, :css_directive

    def initialize
      @technologies = [
        { :group => 'stylesheets', :extension => '.scss', :name => 'scss',
          :css_directive => '@import', :css_prefix => "'", :css_postfix => "';" },
        { :group => 'javascripts', :extension => '.js', :name => 'js' }
      ]
    end
  end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    attr_writer :configuration

    def configure
      yield configuration
    end
  end
end
