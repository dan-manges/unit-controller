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

  test "raise on render then redirect" do
    assert_raises(ActionController::DoubleRenderError) do
      get :render_then_redirect
    end
  end

  test "raise on redirect then render" do
    assert_raises(ActionController::DoubleRenderError) do
      get :redirect_then_render
    end
  end
  
  test "controller remembers what it renders even if rendering view" do
    @controller = @controller.class.new
    assert_equal true, @controller.render_view?
    get :text_foo
    assert_rendered :text => "foo"
    assert_equal "foo", @response.body
  end
  
  test "render_view?" do
    @controller = @controller.class.new
    assert_equal true, @controller.render_view?
    @controller.do_not_render_view
    assert_equal false, @controller.render_view?
  end
end
