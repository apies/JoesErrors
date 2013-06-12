require 'spec_helper'
describe JoeErrorHandler do

  class JoeBunghoe
    include JoeErrorHandler

    def likely_to_fail_method
      #you can't divide anything by zero :D
      2/0
    end

  end

  let(:joe_logger) {JoeLogger.new}
  let(:joe_error_handler) {JoeErrorHandler.new}

  

  #just making sure I can produce an error to catch
  describe JoeBunghoe do
    let(:bungholio) {JoeBunghoe.new}
    
    #lambdas are like passable blocks, in fact they were called lambdas in c# too haha
    it "should raise an error with its silly divide by zero method" do
      lambda {bungholio.likely_to_fail_method}.should raise_error
    end

  end

  describe "Error Handling Methods" do
    let(:bungholio) {JoeBunghoe.new}

    
    it "should be able to catch an error" do
      #arrow is alternative syntax for lambda
      -> do
        bungholio.with_error_handling {likely_to_fail_method}.should_not raise_error
      end
    end

    it "should have fire a callback when it catches an error" do
      #mock
      Dir.should_receive(:pwd)
      bungholio.with_error_handling(lambda { |error| Dir.pwd}) do 
        likely_to_fail_method
      end
    end




  end

  describe "Turning into a DSL" do

    class JoeBungholio
      include JoeErrorHandler


      def example_handling_method
        Dir.pwd
      end

      def likely_to_fail_method
        #you can't divide anything by zero :D
        2/0
      end
      handle_error :likely_to_fail_method, :handle_with => :example_handling_method
      
    end

    let(:joe_bungholio) {JoeBungholio.new}


    it "should be able to catch an error" do

      lambda {joe_bungholio.likely_to_fail_method}.should_not raise_error
    
    end


  end






end