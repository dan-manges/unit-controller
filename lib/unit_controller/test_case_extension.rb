module UnitController
  module TestCaseExtension
    def assert_rendered(options = nil, message = nil)
      assert_equal options, @controller.rendered, message
    end
  end
end
