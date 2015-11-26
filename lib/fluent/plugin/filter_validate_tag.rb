module Fluent
  class ValidateTagFilter < Filter
    Plugin.register_filter('validate_tag', self)

    config_param :max_length, :integer, default: 200

    def configure(conf)
      super

      @regexps = []
      conf.each do |key, value|
        if key =~ /\Aregexp[0-9]+\z/
          @regexps << Regexp.new(value)
        end
      end
    end

    def filter(tag, time, record)
      case
      when tag.size > @max_length
        nil
      when !@regexps.empty? && @regexps.any? {|regexp| regexp !~ tag }
        nil
      else
        record
      end
    end
  end
end
