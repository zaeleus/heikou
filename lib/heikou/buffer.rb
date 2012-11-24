module Heikou
  class Buffer
    include FFI::OpenCL

    attr_reader :mem, :host_ptr, :size, :context

    def initialize(cl, context, options, type, size = 1)
      @cl = cl
      @context = context
      @type = type
      @size = size

      @host_ptr = FFI::MemoryPointer.new type, size

      mark_clean

      create(options)
    end

    def finalize
      reference_count.times { release }
    end

    def retain
      clRetainMemObject(@mem)
    end

    def release
      clReleaseMemObject(@mem)
    end

    def mark_clean
      @dirty = false
    end

    def mark_dirty
      @dirty = true
    end

    def dirty?
      @dirty
    end

    def reference_count
      ref_count = FFI::MemoryPointer.new FFI::OpenCL.find_type(:cl_uint)
      clGetMemObjectInfo(@mem, CL_MEM_REFERENCE_COUNT, ref_count.size, ref_count, nil)
      ref_count.read_uint
    end

    def []=(index, value)
      @host_ptr[index].send("write_#{@type}", value)
    end

    def [](index)
      @host_ptr[index].send("read_#{@type}")
    end

    def read
      @cl.default_queue.read_buffer(self)
      mark_clean
    end

    def to_a
      read if dirty?
      @host_ptr.send("read_array_of_#{@type}", @size)
    end

    private

    def create(options)
      context = @context.context
      size = @host_ptr.size
      host_ptr = ((options & CL_MEM_WRITE_ONLY) != 0) ? nil : @host_ptr

      @mem = clCreateBuffer(context, options, size, host_ptr, nil)
    end
  end
end
