require 'rails/generators/base'

module Bem
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def copy_initializer
        template 'bem.rb', File.join(Rails.root, 'config', 'initializers', 'bem.rb')
      end

      def copy_technologies_templates
        BEM.configuration.technologies.each do |tech|
          copy_file "technologies/#{ tech[:name] }.tt",
            File.join(Rails.root, 'lib', 'bem', 'templates', "#{ tech[:name] }.tt")
        end
      end
    end
  end
end
