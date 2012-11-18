module OpenCL
  class CL
    include FFI::OpenCL

    def finalize
      @contexts.each(&:finalize)
    end

    def platforms
      @platforms ||= Platform.all(cl)
    end

    def default_platform
      platforms.first
    end

    def devices
      @devices ||= Device.all(cl)
    end

    def default_device
      devices.first
    end

    def contexts
      @contexts ||= [Context.new(self, default_device)]
    end

    def default_context
      contexts.first
    end

    def create_program_with_source(source = nil)
      source ||= yield
      Program.new(self, default_context, source)
    end

    def queues
      @queues ||= [Queue.new(self, default_context, default_device)]
    end

    def default_queue
      queues.first
    end
  end
end
