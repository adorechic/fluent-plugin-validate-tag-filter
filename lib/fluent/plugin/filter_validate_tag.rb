require 'fluent/plugin/filter'
module Fluent::Plugin
  class ValidateTagFilter < Filter
    Fluent::Plugin.register_filter('validate_tag', self)

    config_param :max_length, :integer, default: nil

    def configure(conf)
      super

      @regexps = []
      conf.keys.each do |key|
        if key =~ /\Aregexp[0-9]+\z/
          @regexps << Regexp.new(conf[key])
        end
      end
    end

    def filter(tag, time, record)
      case
      when @max_length && tag.size > @max_length
        nil
      when !@regexps.empty? && @regexps.any? {|regexp| regexp !~ tag }
        nil
      else
        record
      end
    end
  end
end
