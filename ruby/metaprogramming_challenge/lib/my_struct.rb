class MyStruct
  def self.new *args, &block
    validate *args

    klass = Class.new do
      include Enumerable

      @@args = args
      args.each do |a|
        class_eval "attr_accessor :#{a}"
      end

      def initialize *vals
        @@args.each do |arg|
          instance_variable_set("@#{arg}", nil)
        end

        vals.each_with_index do |val, ind|
          instance_variable_set("@#{@@args[ind]}", val)
        end
      end

      def [] val
        bracket_guard(val)
        send(val)
      end

      def []= old, new
        bracket_guard(old)
        instance_variable_set("@#{old}", new)
      end

      def bracket_guard val
        raise NameError, "no member '#{val}' in struct" unless respond_to?(val)
      end

      def inspect
        base_string = "#<struct "
        instance_variables.each do |var|
          base_string << "#{var[1..-1]}=#{get_value(var).inspect}, "
        end
        base_string[-2..-1] = ">"
        base_string
      end

      def members
        instance_variables.map{ |v| v.to_s[1..-1].to_sym }
      end

      def select &block
        list = []
        instance_variables.each do |var|
          value = get_value(var)
          list << value if yield value
        end
        list
      end

      def size
        instance_variables.size
      end

      def values
        instance_variables.inject([]) do |acc, elem|
          acc << get_value(elem)
        end
      end

      def each &block
        if block_given?
          instance_variables.each do |var|
            yield get_value(var)
          end
        else
          values.each
        end
      end

      def get_value variable
        send variable[1..-1]
      end
    end

    klass.class_eval &block if block_given?

    return klass
  end

  def self.validate *args
    raise ArgumentError, "wrong number of arguments (0 for 1+)" unless args[0]

    args.each { |a| raise TypeError unless a.class == Symbol }
  end
end
