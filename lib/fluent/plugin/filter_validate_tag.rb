module Fluent
  class ValidateTagFilter < Filter
    Plugin.register_filter('validate_tag', self)

    config_param :max_length, :integer, default: 200

    def configure(conf)
      super

      if conf['pattern']
        @pattern = Regexp.new(conf['pattern'])
      end
    end

    def filter(tag, time, record)
      case
      when tag.size > @max_length
        nil
      when @pattern && @pattern !~ tag
        nil
      else
        record
      end
    end
  end
end
