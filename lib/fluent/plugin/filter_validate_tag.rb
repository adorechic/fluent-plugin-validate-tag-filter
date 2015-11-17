module Fluent
  class ValidateTagFilter < Filter
    Plugin.register_filter('validate_tag', self)

    def configure(conf)
      super
    end

    def filter(tag, time, record)
      record
    end
  end
end
