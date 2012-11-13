module OpenCL
  class CL
    include FFI::OpenCL

    def finalize
      @contexts.each(&:finalize)
    end

    def platforms
      @platforms ||= begin
        platform = FFI::MemoryPointer.new :pointer
        clGetPlatformIDs(1, platform, nil)
        [Platform.new(self, platform.read_pointer)]
      end
    end

    def default_platform
      platforms.first
    end

    def devices
      @devices ||= begin
        platform = default_platform

        num_devices = FFI::MemoryPointer.new :uint
        clGetDeviceIDs(platform.id, CL_DEVICE_TYPE_ALL, 0, nil, num_devices)

        n = num_devices.read_uint
        devices = FFI::MemoryPointer.new :pointer, n
        clGetDeviceIDs(platform.id, CL_DEVICE_TYPE_ALL, n, devices, nil)

        devices.read_array_of_pointer(n).map { |ptr| Device.new(self, ptr) }
      end
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
  end
end
