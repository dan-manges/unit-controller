module UnitController
  module TestCaseExtension
    def assert_rendered(options = nil, message = nil)
      if !@controller.respond_to?(:rendered)
        raise NoMethodError, "#{@controller} did not remember what it rendered. Did you call @controller.do_not_render_view ?"
      end
      assert_equal options, @controller.rendered, message
    end
  end
end
