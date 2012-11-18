module OpenCL
  class Device
    include FFI::OpenCL

    attr_reader :id

    def self.all(cl)
      platform = cl.default_platform

      num_devices = FFI::MemoryPointer.new FFI::OpenCL.find_type(:cl_uint)
      clGetDeviceIDs(platform.id, CL_DEVICE_TYPE_ALL, 0, nil, num_devices)

      n = num_devices.read_uint
      devices = FFI::MemoryPointer.new :pointer, n
      clGetDeviceIDs(platform.id, CL_DEVICE_TYPE_ALL, n, devices, nil)

      devices.read_array_of_pointer(n).map do |ptr|
        Device.new(self, ptr)
      end
    end

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
