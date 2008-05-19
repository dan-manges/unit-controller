require "rubygems"
gem "rails", ENV["RAILS_VERSION"] || ">= 2.0.2"
require "rails/version"
require "action_controller"
require "action_controller/test_process"

if Rails::VERSION::MAJOR >= 2
  require "action_controller/test_case"
end

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')
require "unit_controller"

require "test/unit"
gem "dust", "0.1.6"
require "dust"

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
    klass = Rails::VERSION::MAJOR >= 2 ? rails2_test_case : rails1_test_case
    klass.class_eval &block
    klass
  end
  
  def self.rails2_test_case
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
