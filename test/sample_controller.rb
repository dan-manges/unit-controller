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
  
  def text_foo
    render :text => "foo"
  end
end

SampleController.instance_methods(false).each do |action|
  ActionController::Routing::Routes.add_route \
    "/sample/#{action}", :controller => "sample", :action => action
end
