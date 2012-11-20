module Heikou
  class Kernel
    include FFI::OpenCL

    attr_reader :kernel

    def initialize(cl, program, kernel)
      @cl = cl
      @program = program
      @kernel = kernel
    end

    def finalize
      reference_count.times { release }
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

    def set_arg(index, buffer)
      buffer = buffer.to_buffer(@cl) if buffer.respond_to?(:to_buffer)

      mem = buffer.mem

      value = FFI::MemoryPointer.new FFI::OpenCL.find_type(:cl_mem)
      value.write_pointer mem

      err = clSetKernelArg(@kernel, index, value.size, value)
      Error.check!(err)
    end

    def call(*args)
      args.each_with_index do |arg, i|
        set_arg(i, arg)
      end

      @cl.default_queue.enqueue_nd_range(self)
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
