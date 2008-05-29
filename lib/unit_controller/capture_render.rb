module UnitController
  module CaptureRender
    attr_reader :rendered
    
    def do_not_render_view
      @render_view = false
    end
    
    def render_view?
      instance_variables.include?("@render_view") ? @render_view : true
    end

    def render_with_unit_controller(*args, &block)
      @rendered = args.first
      if render_view?
        render_without_unit_controller *args, &block
      else
        raise ActionController::DoubleRenderError, "Can only render or redirect once per action" if performed?
        @performed_render = true
        response.headers["Status"] = ActionController::Base::DEFAULT_RENDER_STATUS_CODE
      end
    end
    
    def self.included(klass)
      klass.class_eval do
        alias_method_chain :render, :unit_controller
      end
    end
  end
end
