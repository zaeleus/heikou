module OpenCL
  class Queue
    include FFI::OpenCL

    attr_reader :queue

    def initialize(cl, context, device)
      @cl = cl
      @context = context
      @device = device

      create
    end

    def finalize
      reference_count.times { release }
    end

    def retain
      clRetainCommandQueue(@queue)
    end

    def release
      clReleaseCommandQueue(@queue)
    end

    def reference_count
      ref_count = FFI::MemoryPointer.new FFI::OpenCL.find_type(:cl_uint)
      clGetCommandQueueInfo(@queue, CL_QUEUE_REFERENCE_COUNT, ref_count.size, ref_count, nil)
      ref_count.read_uint
    end

    def enqueue_task(kernel)
      kernel = kernel.kernel

      clEnqueueTask(@queue, kernel, 0, nil, nil)
    end
    alias_method :<<, :enqueue_task
    alias_method :add, :enqueue_task

    def enqueue_nd_range(kernel)
      kernel = kernel.kernel

      global_size = FFI::MemoryPointer.new :pointer
      global_size.write_long_long 4096

      clEnqueueNDRangeKernel(@queue, kernel, 1, nil, global_size, nil, 0, nil, nil)

      clFinish(@queue)
    end

    def read_buffer(buffer)
      mem = buffer.mem
      host_ptr = buffer.host_ptr
      size = host_ptr.size

      clEnqueueReadBuffer(@queue, mem, CL_TRUE, 0, size, host_ptr, 0, nil, nil)
    end

    private

    def create
      context = @context.context
      device = @device.id

      @queue = clCreateCommandQueue(context, device, 0, nil)
    end
  end
end
