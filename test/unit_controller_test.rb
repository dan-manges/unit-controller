require File.dirname(__FILE__) + "/test_helper"

if Rails::VERSION::MAJOR >= 2
  class UnitControllerTest < ActionController::TestCase
    tests SampleController

    def setup
      super
      @controller.do_not_render_view
    end
  end  
else
  class UnitControllerTest < Test::Unit::TestCase
    def setup
      @controller = SampleController.new
      @request = ActionController::TestRequest.new
      @response = ActionController::TestResponse.new
      @controller.do_not_render_view
    end
  end
end

UnitControllerTest.class_eval do
  test "action that has view that raises" do
    assert_nothing_raised do
      get :raise_inline
    end
  end
  
  test "assert_response :success works" do
    get :implicit_template
    assert_response :success
  end
  
  test "raise on double render" do
    assert_raises(ActionController::DoubleRenderError) do
      get :double_render
    end
  end
end
