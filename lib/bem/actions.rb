module BEM
  module Actions
    def build_with(options = {})
      BEM.configuration.technologies.each do |tech|
        next puts("#{ tech[:group] } are omitted") unless build?(tech[:group], options)

        handle_bem(options, tech) if options[:block].present?

        handle_level(options, tech) unless options[:include_to_manifest]

        handle_manifest(options, tech) if options[:manifest].present? || options[:include_to_manifest]
      end
    end

    def destroy_with(options = {})
      BEM.configuration.technologies.each do |tech|
        path = build_path_for(tech[:extension], options, tech[:group])

        remove_file File.expand_path('..', path)

        level = level_path(options[:level], tech)

        path_without_extension = path.split("#{ tech[:group] }/").last.sub(tech[:extension], '')

        gsub_file(level, string_to_append(tech, path_without_extension), '') if File.exist? level
      end
    end

    private

    def handle_bem(options, tech)
      path = build_path_for(tech[:extension], options, tech[:group])

      @css_class = File.basename(path, tech[:extension]) if tech[:group] == 'stylesheets'

      template("#{ tech[:name] }.tt", path)
    end

    def handle_level(options, tech)
      path = build_path_for(tech[:extension], options, tech[:group])

      level = level_path(options[:level], tech)

      File.exist?(level) ? (puts("#{ level } already exists") unless options[:block].present?) : create_file(level)

      path_without_extension = path.split("#{ tech[:group] }/").last.sub(tech[:extension], '')

      append_file(level, string_to_append(tech, path_without_extension)) if options[:block].present?
    end

    def handle_manifest(options, tech)
      manifest_name = options[:manifest].present? ? options[:manifest] : 'application'

      manifest = File.join(Rails.root, 'app', 'assets', tech[:group], manifest_name + tech[:extension])

      path = options[:include_to_manifest] ? build_path_for(tech[:extension], options, tech[:group]) :
        level_path(options[:level], tech)

      File.exist?(manifest) ? (puts("#{ manifest } already exists") if !options[:block].present?) : create_file(manifest)

      append_file manifest, string_to_append(tech, path.split("#{ tech[:group] }/").last.sub(tech[:extension], ''))
    end

    def build_path_for(extension, options, group)
      b, e, m, v, t = options[:block], options[:element], options[:modificator], options[:value], extension

      level = options[:level].present? ? options[:level] : Rails.application.class.parent_name.to_s.parameterize

      path = [Rails.root.to_s, 'app', 'assets', group, level]

      if b.present? && e.present? && m.present?
        path += [b, "__#{ e }", "_#{ m }", "#{ b }__#{ e }_#{ m }#{ "_#{ v }" if v.present? }#{ t }"]
      elsif b.present? && e.present?
        path += [b, "__#{ e }", "#{ b }__#{ e + t }"]
      elsif b.present? && m.present?
        path += [b, "_#{ m }", "#{ b }_#{ m }#{ "_#{ v }" if v.present? }#{ t }"]
      elsif b.present?
        path += [b, "#{ b + t }"]
      else
        path += [level + t]
      end

      File.join(path.compact)
    end

    def build?(technology_group, options)
      (options[:css] && technology_group == 'stylesheets') || (options[:js] && technology_group == 'javascripts')
    end

    def level_path(level_name, technology)
      level = level_name.present? ? level_name : Rails.application.class.parent_name.to_s.parameterize

      File.join(Rails.root.to_s, 'app', 'assets', technology[:group], level, "#{ level + technology[:extension] }")
    end

    def string_to_append(technology, path)
      if technology[:group] == 'stylesheets'
        "\n#{ technology[:css_directive] } #{ technology[:css_prefix] + path + technology[:css_postfix] }"
      elsif technology[:group] == 'javascripts'
        "\n//= require #{ path }"
      end
    end
  end
end
