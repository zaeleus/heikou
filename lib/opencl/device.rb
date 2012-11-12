module OpenCL
  class Device
    include FFI::OpenCL

    attr_reader :id

    def initialize(cl, id)
      @cl = cl
      @id = id
    end

    def name
      buffer = FFI::Buffer.new(64)
      clGetDeviceInfo(id, CL_DEVICE_NAME, buffer.size, buffer, nil)
      buffer.get_string(0)
    end 
  end
end
