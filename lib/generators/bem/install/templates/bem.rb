BEM.configure do |config|
  config.technologies = [
    { :group => 'stylesheets', :extension => '.scss', :name => 'scss',
      :css_directive => '@import', :css_prefix => "'", :css_postfix => "';" },
    { :group => 'javascripts', :extension => '.js', :name => 'js' }
  ]
end
