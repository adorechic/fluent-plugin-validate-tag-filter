module Fluent
  class ValidateTagFilter < Filter
    Plugin.register_filter('validate_tag', self)

    config_param :max_length, :integer, default: 200

    def configure(conf)
      super
    end

    def filter(tag, time, record)
      return nil if tag.size > @max_length

      record
    end
  end
end
