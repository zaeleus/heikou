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

    private

    def create
      context = @context.context
      device = @device.id

      @queue = clCreateCommandQueue(context, device, 0, nil)
    end
  end
end
