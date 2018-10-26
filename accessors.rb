# accessors.rb
module Accessors
  def self.included(receiver)
    receiver.extend ClassMethods
    # receiver.send :include, InstanceMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        name_sym = "@#{name}".to_sym
        name_history_sym = "@#{name}_history".to_sym
        define_method(name) { instance_variable_get(name_sym) }
        define_method("#{name}_history".to_sym) { instance_variable_get(name_history_sym) }
        define_method("#{name}=".to_sym) do |value|
          x = instance_variable_get(name_sym)
          history = instance_variable_get(name_history_sym) || []
          instance_variable_set(name_history_sym, history.push(x)) unless x.nil?
          instance_variable_set(name_sym, value)
        end
        private "#{name}=".to_sym # для теста надо закомментировать, для проекта не надо
      end
    end

    def attr_reader_private_writer(*names)
      names.each do |name|
        name_sym = "@#{name}".to_sym
        define_method(name) { instance_variable_get(name_sym) }
        define_method("#{name}=".to_sym) { |value| instance_variable_set(name_sym, value) }
        private "#{name}=".to_sym
      end
    end

    def strong_attr_accessor(attr_name, attr_class)
      attr_name_sym = "@#{attr_name}".to_sym

      define_method(attr_name) { instance_variable_get(attr_name_sym) }
      define_method("#{attr_name}=".to_sym) do |value|
        msg = "Different classes! Is required: #{attr_class} != #{value.class} of #{attr_name} "
        raise msg unless value.class.is_a? attr_class

        instance_variable_set(attr_name_sym, value)
      end
      private "#{attr_name}=".to_sym # для теста надо закомментировать, для проекта не надо
    end
  end
end
