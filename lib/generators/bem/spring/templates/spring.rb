module Spring
  module Commands
    class BEM
      def env(*)
        'development'
      end

      def exec_name
        'bem'
      end
    end

    Spring.register_command 'bem', BEM.new
  end
end
