module OpenCL
  class Platform
    include FFI::OpenCL

    attr_reader :id

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
