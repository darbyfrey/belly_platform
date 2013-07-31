module BellyPlatform
  class Boolean
    TRUTHY_VALUES = [true, "true", "t", "yes", "yep", "yea", "y", 1, "1"]
    FALSY_VALUES  = [false, "false", "f", "no", "nope", "na", "n", 0, "0"]

    class << self
      def convert(value)
        if TRUTHY_VALUES.include? value
          true
        elsif FALSY_VALUES.include? value
          false
        else
          false
        end
      end

      def is_true?(value)
        convert(value)
      end

      def is_false?(value)
        !convert(value)
      end

      def is_boolean?(value)
        (TRUTHY_VALUES + FALSY_VALUES).include? value
      end
    end
  end
end