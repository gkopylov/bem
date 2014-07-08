describe BEM::Actions do
  describe '#build_with' do
    before do
      class DummyClass < Thor
        include BEM::Actions
        include Thor::Actions

        def self.source_root
          File.join(File.dirname(__FILE__), 'sandbox')
        end
      end

      @dummy_object = DummyClass.new

      @dummy_object.create_file 'spec/sandbox/scss.tt'

      Rails.stub(:root).and_return(sandbox_root)

      Rails.application.class.stub(:parent_name).and_return('fakeapp')
    end

    subject { @dummy_object.build_with(options) }

    describe 'when empty default options' do
      before do
        @dummy_object.remove_file "#{ sandbox_root }/app/assets/javascripts/fakeapp/fakeapp.js"

        @dummy_object.remove_file "#{ sandbox_root }/app/assets/stylesheets/fakeapp/fakeapp.scss"
      end

      def options
        { :js => true, :css => true }
      end

      it { expect(capture(:stdout) { subject }).to match "      " +
        "create  spec/sandbox/app/assets/stylesheets/fakeapp/fakeapp.scss\n      " + 
        "create  spec/sandbox/app/assets/javascripts/fakeapp/fakeapp.js\n"
      }
    end

    describe 'when create only stylesheets' do
      before do
        @dummy_object.remove_file "#{ sandbox_root }/app/assets/stylesheets/fakeapp/fakeapp.scss"
      end

      def options
        { :css => true }
      end

      it { expect(capture(:stdout) { subject }).to match "      " +
        "create  spec/sandbox/app/assets/stylesheets/fakeapp/fakeapp.scss\n"
      }
    end

    describe 'when create only specific level' do
      before do
        @dummy_object.remove_file "#{ sandbox_root }/app/assets/stylesheets/somelevel/somelevel.scss"
      end

      def options
        { :css => true, :level => 'somelevel' }
      end

      it { expect(capture(:stdout) { subject }).to match "      " + 
        "create  spec/sandbox/app/assets/stylesheets/somelevel/somelevel.scss\n" +
        "javascripts are omitted\n"
      }
    end

    describe 'when create a block' do
      before do
        @dummy_object.remove_file "#{ sandbox_root }/app/assets/stylesheets/fakeapp/someblock/someblock.scss"
      end

      def options
        { :css => true, :block => 'someblock' }
      end

      it { expect(capture(:stdout) { subject }).to match "      " +
        "create  spec/sandbox/app/assets/stylesheets/fakeapp/someblock/someblock.scss\n      " +
        "append  spec/sandbox/app/assets/stylesheets/fakeapp/fakeapp.scss\n" +
        "javascripts are omitted\n"
      }
    end

    describe 'when create an element within a block' do
      before do
        @dummy_object.remove_file "#{ sandbox_root }/app/assets/stylesheets/fakeapp/someblock/someblock.scss"

        @dummy_object.remove_file "#{ sandbox_root }/app/assets/stylesheets/fakeapp/someblock/__someelement/" +
          "someblock__someelement.scss"
      end

      def options
        { :css => true, :block => 'someblock', :element => 'someelement' }
      end

      it { expect(capture(:stdout) { subject }).to match  "      " +
        "create  spec/sandbox/app/assets/stylesheets/fakeapp/someblock/__someelement/someblock__someelement.scss\n" +
        "      " +
        "append  spec/sandbox/app/assets/stylesheets/fakeapp/fakeapp.scss\n" +
        "javascripts are omitted\n"
      }
    end

    describe 'when create a block modificator' do
      before do
        @dummy_object.remove_file "#{ sandbox_root }/app/assets/stylesheets/fakeapp/someblock/someblock.scss"

        @dummy_object.remove_file "#{ sandbox_root }/app/assets/stylesheets/fakeapp/someblock/_somemod/" +
          "someblock_somemod.scss"
      end

      def options
        { :css => true, :block => 'someblock', :modificator => 'somemod' }
      end

      it { expect(capture(:stdout) { subject }).to match  "      " +
        "create  spec/sandbox/app/assets/stylesheets/fakeapp/someblock/_somemod/someblock_somemod.scss\n      " +
        "append  spec/sandbox/app/assets/stylesheets/fakeapp/fakeapp.scss\n" +
        "javascripts are omitted\n"
      }
    end

    describe 'when create an element modificator within a block' do
      before do
        @dummy_object.remove_file "#{ sandbox_root }/app/assets/stylesheets/fakeapp/someblock/someblock.scss"

        @dummy_object.remove_file "#{ sandbox_root }/app/assets/stylesheets/fakeapp/someblock/__someelement/" +
          "_somemod/someblock__someelement_somemod.scss"
      end

      def options
        { :css => true, :block => 'someblock', :modificator => 'somemod', :element => 'someelement' }
      end

      it { expect(capture(:stdout) { subject }).to match  "      " +
        "create  spec/sandbox/app/assets/stylesheets/fakeapp/someblock/__someelement/_somemod/" +
        "someblock__someelement_somemod.scss\n      " +
        "append  spec/sandbox/app/assets/stylesheets/fakeapp/fakeapp.scss\n" +
        "javascripts are omitted\n"
      }
    end
  end

  describe '#destroy_with' do
    before do
      class DummyClass < Thor
        include BEM::Actions
        include Thor::Actions

        def self.source_root
          File.join(File.dirname(__FILE__), 'sandbox')
        end
      end

      @dummy_object = DummyClass.new

      @dummy_object.create_file 'spec/sandbox/scss.tt'

      Rails.stub(:root).and_return(sandbox_root)

      Rails.application.class.stub(:parent_name).and_return('fakeapp')
    end

    subject { @dummy_object.destroy_with(options) }

    describe 'when empty default options' do
      def options
        { :js => true, :css => true }
      end

      it { expect(capture(:stdout) { subject }).to match "      " +
        "remove  spec/sandbox/app/assets/stylesheets/fakeapp\n      " + 
        "remove  spec/sandbox/app/assets/javascripts/fakeapp\n"
      }
    end

    describe 'when destroy only specific level' do
      def options
        { :level => 'somelevel' }
      end

      it { expect(capture(:stdout) { subject }).to match "      " + 
        "remove  spec/sandbox/app/assets/stylesheets/somelevel\n" + "      "
        "remove  spec/sandbox/app/assets/stylesheets/somelevel\n"
      }
    end

    describe 'when destroy a block' do
      def options
        { :block => 'someblock' }
      end

      it { expect(capture(:stdout) { subject }).to match "      " +
        "remove  spec/sandbox/app/assets/stylesheets/fakeapp/someblock\n      " +
        "remove  spec/sandbox/app/assets/javascripts/fakeapp/someblock\n"
      }
    end

    describe 'when destroy an element within a block' do
      def options
        { :block => 'someblock', :element => 'someelement' }
      end

      it { expect(capture(:stdout) { subject }).to match  "      " +
        "remove  spec/sandbox/app/assets/stylesheets/fakeapp/someblock/__someelement\n" + "      " +
        "remove  spec/sandbox/app/assets/javascripts/fakeapp/someblock/__someelement\n"
      }
    end

    describe 'when destroy a block modificator' do
      def options
        { :block => 'someblock', :modificator => 'somemod' }
      end

      it { expect(capture(:stdout) { subject }).to match  "      " +
        "remove  spec/sandbox/app/assets/stylesheets/fakeapp/someblock/_somemod\n      " +
        "remove  spec/sandbox/app/assets/javascripts/fakeapp/someblock/_somemod\n"
      }
    end

    describe 'when destroy an element modificator within a block' do
      def options
        { :block => 'someblock', :modificator => 'somemod', :element => 'someelement' }
      end

      it { expect(capture(:stdout) { subject }).to match  "      " +
        "remove  spec/sandbox/app/assets/stylesheets/fakeapp/someblock/__someelement/_somemod\n      " +
        "remove  spec/sandbox/app/assets/javascripts/fakeapp/someblock/__someelement/_somemod\n"
      }
    end
  end
end
