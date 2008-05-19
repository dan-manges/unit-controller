require File.dirname(__FILE__) + "/test_helper"

TestHelper.define_test_case do
  test "assert_rendered" do
    get :text_foo
    assert_passes do
      assert_rendered :text => "foo"
    end
    assert_fails do
      assert_rendered :text => "bar"
    end
  end
  
  test "assert_rendered on implicit_template" do
    get :implicit_template
    assert_passes do
      assert_rendered
    end
    assert_fails do
      assert_rendered :something_that_it_didnt_render
    end
  end
end
