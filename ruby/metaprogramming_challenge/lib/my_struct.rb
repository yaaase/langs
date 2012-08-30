class MyStruct
  def self.new *args, &block
    self.validate *args

    klass = Class.new do
      include Enumerable

      @@args = args
      args.each do |a|
        self.class_eval "attr_accessor :#{a}"
      end

      def initialize *vals
        @@args.each do |arg|
          self.instance_variable_set "@#{arg}", nil
        end

        vals.each_with_index do |val, ind|
          self.instance_variable_set "@#{@@args[ind]}", val
        end
      end

      def [] val
        unless self.respond_to? val
          raise NameError, "no member '#{val}' in struct"
        else
          self.send val
        end
      end

      def []= old, new
        unless self.respond_to? old
          raise NameError, "no member '#{old}' in struct"
        else
          self.instance_variable_set "@#{old}", new
        end
      end

      def inspect
        base_string = "#<struct "
        self.instance_variables.each do |var|
          base_string << "#{var[1..-1]}=#{self.get_value(var).inspect}, "
        end
        base_string[-2..-1] = ">"
        base_string
      end

      def members
        self.instance_variables.map{ |v| v.to_s[1..-1].to_sym }
      end

      def select &block
        list = []
        self.instance_variables.each do |var|
          value = self.get_value var
          list << value if yield value
        end
        list
      end

      def size
        self.instance_variables.size
      end

      def values
        list = []
        self.instance_variables.each do |var|
          list << self.get_value(var)
        end
        list
      end

      def each &block
        if block_given?
          self.instance_variables.each do |var|
            yield self.get_value var
          end
        else
          self.values.each
        end
      end

      def get_value variable
        self.send variable[1..-1]
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
