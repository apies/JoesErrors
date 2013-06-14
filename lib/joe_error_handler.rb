module JoeErrorHandler

  def self.included(base)
    base.extend HandlerDSL
  end

  def with_error_handling(error_handling_callback, &block)
    begin
      block.call if block_given?
    rescue => error
      error_handling_callback.call(error) if error_handling_callback 
    end
  end

  


  module HandlerDSL
    def handle_error(protected_method, options = {})
      alias_method("_#{protected_method}", protected_method)
      define_method(protected_method, 
        ->(params = nil) do
          error_method_lambda = ->(error=nil) {self.send(options[:handle_with], error)}
          with_error_handling(error_method_lambda) do
            self.send("_#{protected_method}".to_sym)
          end
        end
      )
    end
  end




end
