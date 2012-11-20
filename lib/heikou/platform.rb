module Heikou
  class Platform
    include FFI::OpenCL

    attr_reader :id

    def self.all(cl)
      num_platforms = FFI::MemoryPointer.new FFI::OpenCL.find_type(:cl_uint)
      err = clGetPlatformIDs(0, nil, num_platforms)
      Error.check!(err)

      n = num_platforms.read_uint
      platforms = FFI::MemoryPointer.new(FFI::OpenCL.find_type(:cl_platform_id), n)
      err = clGetPlatformIDs(n, platforms, num_platforms)
      Error.check!(err)

      platforms.read_array_of_pointer(n).map do |ptr|
        Platform.new(cl, ptr)
      end
    end

    def initialize(cl, id)
      @cl = cl
      @id = id
    end

    def name
      info(:name)
    end

    def info(type, size = 64)
      buffer = FFI::Buffer.new size
      name = self.class.const_get("CL_PLATFORM_#{type.to_s.upcase}")
      clGetPlatformInfo(@id, name, buffer.size, buffer, nil)
      buffer.get_string(0)
    end
  end
end
