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
    end

    def retain
      clRetainCommandQueue(@queue)
    end

    def release
      clReleaseCommandQueue(@queue)
    end

    def enqueue_task(kernel)
      kernel = kernel.kernel

      clEnqueueTask(@queue, kernel, 0, nil, nil)
    end
    alias_method :<<, :enqueue_task
    alias_method :add, :enqueue_task

    private

    def create
      context = @context.context
      device = @device.id

      @queue = clCreateCommandQueue(context, device, 0, nil)
    end
  end
end
