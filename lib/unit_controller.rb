require "unit_controller/capture_render"
require "unit_controller/no_view_rendering"
require "unit_controller/test_case_extension"
ActionController::Base.send :include, UnitController::NoViewRendering
Test::Unit::TestCase.send :include, UnitController::TestCaseExtension
