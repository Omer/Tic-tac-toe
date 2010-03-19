Dir[File.join(File.dirname(File.dirname(__FILE__)),'*.rb')].each {|file| require file unless file =~ /run.rb/}

module TicTacToeSpecHelper
  class Increase
    def initialize(&expected)
      @expected = expected
    end

    def matches?(actual)
      @original_value = @expected.call
      actual.call
      @new_value = @expected.call
      return @new_value.to_i > @original_value.to_i
    end

    def failure_message
      "expected #{@new_value} to be greater than #{@original_value.inspect}"
    end

    def negative_failure_message
      "expected #{@new_value} not to greater than #{@original_value.inspect}"
    end
  end

  def increase(&expected)
    Increase.new(&expected)
  end
end