module UnitController
  module CaptureRender
    attr_reader :rendered
    
    def render(options = nil)
      raise ActionController::DoubleRenderError.new if performed?
      @performed_render = true
      @rendered = options
      response.headers["Status"] = "200"
    end
  end
end
