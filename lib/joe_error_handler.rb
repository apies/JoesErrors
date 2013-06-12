module JoeErrorHandler

  def self.included(base)
    base.extend ClassMethods
  end


  def with_error_handling(error_handling_callback, &block)
    begin
      self.block.call
    rescue => error
      #puts "an error was found:#{error}"
      error_handling_callback.call(error) if error_handling_callback 
    end
  end

  module ClassMethods

    def handle_error(protected_method, options = {})
      alias_method("_#{protected_method}", protected_method)
      #with_error_handling
      define_method(protected_method.to_s, 
        ->(params = nil) do
          with_error_handling(lambda { |error| Dir.pwd}) do
            self.call(protected_method)
          end
        end
      )
    end
  end




end
