module UnitController
  module NoViewRendering
    def do_not_render_view
      extend UnitController::CaptureRender
    end
  end
end
