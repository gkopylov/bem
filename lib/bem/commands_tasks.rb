class CommandsTasks < Thor
  include BEM::Actions
  include Thor::Actions

  def self.source_root
    File.join(Rails.root.to_s, 'lib', 'bem', 'templates')
  end

  desc 'create', 'Create level, block, element or modificator'
  method_option :block, :type => :string, :aliases => '-b', :desc => 'Create or use given block.'
  method_option :element, :type => :string, :aliases => '-e', :desc => 'Create or use given element.'
  method_option :modificator, :type => :string, :aliases => '-m', :desc => 'Create modificator.'
  method_option :value, :type => :string, :aliases => '-v', :desc => 'Value for modificator.'
  method_option :level, :type => :string, :aliases => '-l', :desc => 'Create or use given level.'
  method_option :manifest, :type => :string, :aliases => '-a', :desc => 'Manifests to append level'
  method_option :js, :default => true, :type => :boolean, :aliases => '-j', :desc => 'Do create assets with javascripts'
  method_option :css, :default => true, :type => :boolean, :aliases => '-s', :desc => 'Do create assets with stylesheets'
  method_option :include_to_manifest, :type => :boolean, :aliases => '-i', :desc => 'Include css asset to manifest'
  def create
    build_with options
  end

  desc 'destroy', 'Destroy level, block, element or modificator'
  method_option :block, :type => :string, :aliases => '-b', :desc => 'Destroy or use given block.'
  method_option :element, :type => :string, :aliases => '-e', :desc => 'Destroy or use give element.'
  method_option :mod, :type => :string, :aliases => '-m', :desc => 'Destroy modificator.'
  method_option :value, :type => :string, :aliases => '-v', :desc => 'Value for modificator.'
  method_option :level, :type => :string, :aliases => '-l', :desc => 'Destroy or use given level.'
  method_option :manifest, :type => :string, :aliases => '-a', :desc => 'Manifests to append level'
  def destroy
    destroy_with options
  end
end
