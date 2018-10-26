# validation
module Validation
  def self.included(receiver)
    receiver.extend ClassMethods
    receiver.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, type, option = nil?)
      msg = "This type: < #{type} > of validation is not supported !"
      raise msg unless %i[presence format type negative].include?(type)

      @checks ||= {}
      @checks[type] ||= []
      @checks[type] << { name: name, option: option }
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    # max-underthesun say me this algorithm
    def validate!
      valds = self.class.instance_variable_get('@checks')
      %i[presence format type negative].each do |type|
        method_check = "#{type}_valid"
        next if valds[type].nil?

        valds[type].each do |check|
          value = instance_variable_get("@#{check[:name]}")
          send(method_check, value, check[:option])
        end
      end
    end

    def negative_valid(value, _argument)
      raise puts "\nValidation error! Negative value = #{value.to_f} !" if value.to_f < 0
    end

    def presence_valid(value, _argument)
      raise puts "\nValidation error! Empty  !" if value.to_s.strip.empty?
    end

    def format_valid(value, argument)
      raise puts "\nValidation error! Invalid < #{value} > format!" if value.to_s !~ argument #  value.to_s --> и числа проверять!method_check
    end

    def type_valid(value, argument)
      raise puts "\nValidation error! Invalid type!" unless value.instance_of?(argument)
    end
  end
end
