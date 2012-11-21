module Heikou
  class Program
    include FFI::OpenCL

    attr_reader :program, :context

    def initialize(cl, context, sources)
      @cl = cl
      @context = context
      @sources = sources.is_a?(String) ? [sources] : sources
      @kernels = {}

      create
      build
    end

    def finalize
      @kernels.values.each(&:finalize)
      reference_count.times { release }
    end

    def retain
      clRetainProgram(@program)
    end

    def release
      clReleaseProgram(@program)
    end

    def devices
      @context.devices
    end

    def num_devices
      @context.num_devices
    end

    def source
      @sources.join("\n")
    end

    def reference_count
      ref_count = FFI::MemoryPointer.new FFI::OpenCL.find_type(:cl_uint)
      clGetProgramInfo(@program, CL_PROGRAM_REFERENCE_COUNT, ref_count.size, ref_count, nil)
      ref_count.read_uint
    end

    def build_status
      status = FFI::MemoryPointer.new FFI::OpenCL.find_type(:cl_build_status)
      clGetProgramBuildInfo(@program, @cl.default_device.id, CL_PROGRAM_BUILD_STATUS, status.size, status, nil)
      status.read_int
    end

    def build_options
      options = FFI::Buffer.new 128
      clGetProgramBuildInfo(@program, @cl.default_device.id, CL_PROGRAM_BUILD_OPTIONS, options.size, options, nil)
      options.get_string(0)
    end

    def build_log
      log_size = FFI::MemoryPointer.new :size_t
      clGetProgramBuildInfo(@program, @cl.default_device.id, CL_PROGRAM_BUILD_LOG, 0, nil, log_size)
      log_size = log_size.read_uint

      log = FFI::MemoryPointer.new :string, log_size + 1
      clGetProgramBuildInfo(@program, @cl.default_device.id, CL_PROGRAM_BUILD_LOG, log_size + 1, log, nil)
      log.read_string
    end

    def to_kernel(name)
      err = Error.buffer
      kernel = clCreateKernel(@program, name, err)
      Error.check!(err)

      @kernels[name] = Kernel.new(@cl, self, kernel)
    end

    def to_kernels
      num_kernels = FFI::MemoryPointer.new FFI::OpenCL.find_type(:cl_uint)
      err = clCreateKernelsInProgram(@program, 0, nil, num_kernels)
      Error.check!(err)

      n = num_kernels.read_uint
      kernels = FFI::MemoryPointer.new FFI::OpenCL.find_type(:cl_kernel), n
      err = clCreateKernelsInProgram(@program, n, kernels, nil)

      kernels.read_array_of_pointer(n).map do |ptr|
        kernel = Kernel.new(@cl, self, ptr)
        @kernels[kernel.name] = kernel
        kernel
      end
    end

    private

    def create
      context = @context.context
      size = @sources.size
      sources = FFI::MemoryPointer.new :string, size
      sizes = FFI::MemoryPointer.new :size_t, size

      @sources.each_with_index do |source, i|
        sources[i].write_pointer FFI::MemoryPointer.from_string(source)
        sizes[i].write_pointer source.size
      end

      err = Error.buffer
      @program = clCreateProgramWithSource(context, size, sources, sizes, err)
      Error.check!(err)
    end

    def build
      devices = FFI::MemoryPointer.new FFI::OpenCL.find_type(:cl_device_id), @context.num_devices

      @context.devices.each_with_index do |device, i|
        devices[i].write_pointer device.id
      end

      err = clBuildProgram(@program, @context.num_devices, devices, nil, nil, nil)
      Error.check!(err)
    end
  end
end
