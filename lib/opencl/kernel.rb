module OpenCL
  class Kernel
    include FFI::OpenCL

    attr_reader :kernel

    def initialize(cl, program, kernel)
      @cl = cl
      @program = program
      @kernel = kernel
    end

    def finalize
      release until reference_count == 0
    end

    def retain
      clRetainKernel(@kernel)
    end

    def release
      clReleaseKernel(@kernel)
    end

    def name
      name = FFI::Buffer.new 128
      clGetKernelInfo(@kernel, CL_KERNEL_FUNCTION_NAME, name.size, name, nil)
      name.get_string(0)
    end

    def num_args
      num_args = FFI::MemoryPointer.new FFI::OpenCL.find_type(:cl_uint)
      clGetKernelInfo(@kernel, CL_KERNEL_NUM_ARGS, num_args.size, num_args, nil)
      num_args.read_uint
    end

    def reference_count
      ref_count = FFI::MemoryPointer.new FFI::OpenCL.find_type(:cl_uint)
      clGetKernelInfo(@kernel, CL_KERNEL_REFERENCE_COUNT, ref_count.size, ref_count, nil)
      ref_count.read_uint
    end

    def set_arg(index, value)
      size = FFI::OpenCL.find_type(:cl_uint).size
      clSetKernelArg(@kernel, index, size, value.host_ptr)
    end

    def call(*args)
      args.each_with_index do |arg, i|
        set_arg(i, arg)
      end
    end
    alias_method :[], :call

    def context
      @program.context
    end

    def program
      @program
    end
  end
end
