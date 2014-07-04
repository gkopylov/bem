require 'rails/generators/base'

module Bem
  module Generators
    class SpringGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def copy_spring_config
        template 'spring.rb', File.join(Rails.root, 'config', 'spring.rb')
      end
    end
  end
end
