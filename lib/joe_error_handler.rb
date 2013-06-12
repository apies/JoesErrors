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
      define_method(protected_method, 
        ->(params = nil) do
          with_error_handling(lambda { |error| puts "YOUR ERROR IS BEING HANDLED!!#{error}"}) do
            self.call(_protected_method)
          end
        end
      )

      # define_method(protected_method, 
      #   ->(params = nil) do
      #     with_error_handling( self.call(options[:handle_with]) ) do
      #       self.call(_protected_method)
      #     end
      #   end
      # )

      #define_method(protected_method, ->(params = nil){with_error_handling(error_callback"method")})
    end
  end




end
