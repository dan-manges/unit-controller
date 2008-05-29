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
  
  def render_then_redirect
    render :text => "hi"
    redirect_to :action => :text_foo
  end
  
  def redirect_then_render
    redirect_to :action => :text_foo
    render :text => "hi"
  end

  def text_foo
    render :text => "foo"
  end
end

# Re-raise errors caught by the controller.
class SampleController; def rescue_action(e) raise e end; end

SampleController.instance_methods(false).each do |action|
  ActionController::Routing::Routes.add_route \
    "/sample/#{action}", :controller => "sample", :action => action
end
