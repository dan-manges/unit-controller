require File.dirname(__FILE__) + "/test_helper"

class SampleController < ActionController::Base
  def double_render
    render :text => "once"
    render :text => "twice"
  end

  def implicit_template
  end
  
  def raise_inline
    render :inline => "<% raise 'raise in template' %>"
  end
end

SampleController.instance_methods(false).each do |action|
  ActionController::Routing::Routes.add_route \
    "/sample/#{action}", :controller => "sample", :action => action
end

class UnitControllerTest < ActionController::TestCase
  tests SampleController
  
  def setup
    super
    @controller.do_not_render_view
  end
  
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
