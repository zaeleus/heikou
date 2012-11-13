module OpenCL
  class Context
    include FFI::OpenCL

    attr_reader :context, :devices

    def initialize(cl, devices)
      @cl = cl
      @devices = devices.is_a?(Device) ? [devices] : devices
      create
    end

    def finalize
      release until reference_count == 0
    end

    def retain
      clRetainContext(@context)
    end

    def release
      clReleaseContext(@context)
    end

    def reference_count
      ref_count = FFI::MemoryPointer.new FFI::OpenCL.find_type(:cl_uint)
      clGetContextInfo(@context, CL_CONTEXT_REFERENCE_COUNT, ref_count.size, ref_count, nil)
      ref_count.read_uint
    end

    def num_devices
      @devices.size
    end

    private

    def create
      devices = FFI::MemoryPointer.new :pointer, @devices.size

      @devices.each_with_index do |device, i|
        devices[i].write_pointer device.id
      end

      @context = clCreateContext(nil, @devices.size, devices, nil, nil, nil)
    end
  end
end
