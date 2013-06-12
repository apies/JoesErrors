require 'spec_helper'

describe JoeLogger do

  before :all do
    JoeError.delete_all
  end

  subject(:joe_logger){ JoeLogger.new }
  
  it "should log an error to the error db" do
    joe_logger.log_error(:message => "something bad happened", :error_type => 'connection error')
    joe_error = JoeError.where(:message =>"something bad happened", :error_type => 'connection error' ).first
    joe_error.message.should eq "something bad happened"
  end


end