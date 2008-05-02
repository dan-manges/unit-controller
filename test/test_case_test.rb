require File.dirname(__FILE__) + "/test_helper"

if Rails::VERSION::MAJOR >= 2
  class TestCaseTest < ActionController::TestCase
    tests SampleController

    def setup
      super
      @controller.do_not_render_view
    end
  end  
else
  class TestCaseTest < Test::Unit::TestCase
    def setup
      @controller = SampleController.new
      @request = ActionController::TestRequest.new
      @response = ActionController::TestResponse.new
      @controller.do_not_render_view
    end
  end
end

TestCaseTest.class_eval do
  test "assert_rendered" do
    get :text_foo
    assert_passes do
      assert_renders :text => "foo"
    end
    assert_fails do
      assert_renders :text => "bar"
    end
  end
  
  test "assert_rendered on implicit_template" do
    get :implicit_template
    assert_passes do
      assert_renders
    end
    assert_fails do
      assert_renders :something_that_it_didnt_render
    end
  end
end
