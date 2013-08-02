module BellyPlatform
  class String
    class << self
      def validate(type, value)
        case type
        when 'integer', 'int'
          !!(value =~ /^-?\d*(,\d*)*$/)
        when 'boolean'
          BellyPlatform::Boolean.is_boolean?(value)
        when 'timestamp'
          !!(value =~ /^(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}($|(\.\d+)$))|^(\d{10})$/)
        when 'double'
          !!(value =~ /^-?\d*.\d*$/)
        when 'array_of_integers', 'array_of_ints'
          value = value.split(',')
          value.is_a?(Array) && value.all?{|i| !!(i =~ /^\d*(,\d*)*$/)}
        when 'array_of_strings'
          value = value.split(',')
          value.is_a?(Array) && value.all?{|i| !!(i =~ /^[.\d\w-][.\d\w-]*(,[.\d\w-][.\d\w-]*)*$/)}
        when 'snake_case'
          !!(value =~ /^[a-zA-Z0-9_-]+$/)
        end 
      end

      def coerce(type, value)
        case type
        when 'integer', 'int'
          value.to_i
        when 'boolean'
          !!value
        when 'double'
          value.to_f
        when 'array_of_integers', 'array_of_ints'
          value.split(',').map{|v| v.to_i}
        when 'array_of_strings'
          value.split(',')
        when 'timestamp'
          if !!(value =~ /^(\d{10})$/)
            Time.at(value.to_i)
          elsif !!(value =~ /^(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}($|(\.\d+)$))/)
            Time.parse(value)
          end
        else
          value
        end
      end
    end
  end
end