module UnitController
  module CaptureRender
    def render(*args)
      raise ActionController::DoubleRenderError.new if performed?
      @performed_render = true
      response.headers["Status"] = "200"
    end
  end
end
