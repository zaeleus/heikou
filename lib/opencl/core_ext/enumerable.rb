module Enumerable
  def to_buffer(cl)
    type = case self.first
           when Float then :float
           when Integer then :int
           end

    options = FFI::OpenCL::CL_MEM_READ_ONLY | FFI::OpenCL::CL_MEM_USE_HOST_PTR
    buffer = cl.create_buffer type, size, options

    each_with_index do |e, i|
      buffer[i] = e
    end

    buffer
  end
end
