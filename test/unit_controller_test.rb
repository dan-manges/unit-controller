require File.dirname(__FILE__) + "/test_helper"

TestHelper.define_test_case do
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
  
  test "friendly error message if you forgot to tell controller not to render view" do
    @controller = @controller.class.new
    exception = nil
    begin
      assert_rendered @controller
    rescue NoMethodError => exception
    end
    assert_not_nil exception
    assert_equal "#{@controller} did not remember what it rendered. Did you call @controller.do_not_render_view ?", exception.message
  end
end
