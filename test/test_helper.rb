require "rubygems"
gem "rails", ENV["RAILS_VERSION"] || ">= 2.0.2"
require "rails/version"
puts "==== Testing with Rails #{Rails::VERSION::STRING} ===="
require "action_controller"
require "action_controller/test_process"

if Rails::VERSION::MAJOR >= 2
  require "action_controller/test_case"
end

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')
require "unit_controller"

require "test/unit"

Test::Unit::TestCase.class_eval do
  def self.test(name, &block)
    test_name = "test_" + name.gsub(/\W/, "_")
    if self.instance_methods.include? test_name
      raise "#{test_name} is already defined in #{self}"
    end
    define_method test_name, &block
  end
end

require File.dirname(__FILE__) + "/sample_controller"

Test::Unit::TestCase.class_eval do
  def assert_fails(&block)
    assert_raises Test::Unit::AssertionFailedError, &block
  end

  def assert_passes
    yield
  end
end

module TestHelper
  def self.define_test_case(&block)
    klass = if Rails::VERSION::MAJOR >= 2
      Rails::VERSION::MINOR.zero? ? rails2_0_test_case : rails2_test_case
    else
      rails1_test_case
    end
    klass.class_eval &block
    klass
  end
  
  def self.rails2_test_case(&block)
    klass = Class.new(ActionController::TestCase)
    klass.class_eval do
      tests SampleController

      def setup
        @controller.do_not_render_view
      end
    end
    klass
  end

  def self.rails2_0_test_case
    klass = Class.new(ActionController::TestCase)
    klass.class_eval do
      tests SampleController

      def setup
        super
        @controller.do_not_render_view
      end
    end
    klass
  end
  
  def self.rails1_test_case
    klass = Class.new(Test::Unit::TestCase)
    klass.class_eval do
      def setup
        @controller = SampleController.new
        @request = ActionController::TestRequest.new
        @response = ActionController::TestResponse.new
        @controller.do_not_render_view
      end
    end
    klass
  end
end

# tests weren't running on rails 2.2.0 without this !?!?!?
if Rails::VERSION::STRING[0,3] == "2.2"
  at_exit { subclasses_of(Test::Unit::TestCase) }
end
