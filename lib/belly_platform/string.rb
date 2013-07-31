module BellyPlatform
  class String
    class << self
      def validate(type, value)
        case type
        when 'integer'
          !!(value =~ /^-?\d*(,\d*)*$/)
        when 'boolean'
          BellyPlatform::Boolean.is_boolean?(value)
        when 'timestamp'
          !!(value =~ /^(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})$|^(\d{10})$/)
        when 'array_of_integers'
          value = value.split(',')
          value.is_a?(Array) && value.all?{|i| !!(i =~ /^\d*(,\d*)*$/)}
        when 'array_of_strings'
          value = value.split(',')
          value.is_a?(Array) && value.all?{|i| !!(i =~ /^[.\d\w-][.\d\w-]*(,[.\d\w-][.\d\w-]*)*$/)}
        end 
      end

      def coerce(type, value)
        case type
        when 'int'
          value.to_i
        when 'array_of_strings'
          value.split(',')
        when 'timestamp'
          Time.at(value.to_i)
        else
          value
        end
      end
    end
  end
end