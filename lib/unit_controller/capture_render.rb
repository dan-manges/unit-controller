module UnitController
  module CaptureRender
    attr_reader :rendered
    
    def render(options = nil)
      raise ActionController::DoubleRenderError, "Can only render or redirect once per action" if performed?
      @performed_render = true
      @rendered = options
      response.headers["Status"] = ActionController::Base::DEFAULT_RENDER_STATUS_CODE
    end
  end
end
