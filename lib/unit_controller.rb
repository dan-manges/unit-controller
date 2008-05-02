require "unit_controller/capture_render"
require "unit_controller/no_view_rendering"
ActionController::Base.send :include, UnitController::NoViewRendering
