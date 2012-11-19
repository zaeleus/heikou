module OpenCL
  class Error
    include FFI::OpenCL

    MAP = {
        0 => 'CL_SUCCESS',
       -1 => 'CL_DEVICE_NOT_FOUND',
       -2 => 'CL_DEVICE_NOT_AVAILABLE',
       -3 => 'CL_COMPILER_NOT_AVAILABLE',
       -4 => 'CL_MEM_OBJECT_ALLOCATION_FAILURE',
       -5 => 'CL_OUT_OF_RESOURCES',
       -6 => 'CL_OUT_OF_HOST_MEMORY',
       -7 => 'CL_PROFILING_INFO_NOT_AVAILABLE',
       -8 => 'CL_MEM_COPY_OVERLAP',
       -9 => 'CL_IMAGE_FORMAT_MISMATCH',
      -10 => 'CL_IMAGE_FORMAT_NOT_SUPPORTED',
      -11 => 'CL_BUILD_PROGRAM_FAILURE',
      -12 => 'CL_MAP_FAILURE',
      -13 => 'CL_MISALIGNED_SUB_BUFFER_OFFSET',
      -14 => 'CL_EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST',
      -30 => 'CL_INVALID_VALUE',
      -31 => 'CL_INVALID_DEVICE_TYPE',
      -32 => 'CL_INVALID_PLATFORM',
      -33 => 'CL_INVALID_DEVICE',
      -34 => 'CL_INVALID_CONTEXT',
      -35 => 'CL_INVALID_QUEUE_PROPERTIES',
      -36 => 'CL_INVALID_COMMAND_QUEUE',
      -37 => 'CL_INVALID_HOST_PTR',
      -38 => 'CL_INVALID_MEM_OBJECT',
      -39 => 'CL_INVALID_IMAGE_FORMAT_DESCRIPTOR',
      -40 => 'CL_INVALID_IMAGE_SIZE',
      -41 => 'CL_INVALID_SAMPLER',
      -42 => 'CL_INVALID_BINARY',
      -43 => 'CL_INVALID_BUILD_OPTIONS',
      -44 => 'CL_INVALID_PROGRAM',
      -45 => 'CL_INVALID_PROGRAM_EXECUTABLE',
      -46 => 'CL_INVALID_KERNEL_NAME',
      -47 => 'CL_INVALID_KERNEL_DEFINITION',
      -48 => 'CL_INVALID_KERNEL',
      -49 => 'CL_INVALID_ARG_INDEX',
      -50 => 'CL_INVALID_ARG_VALUE',
      -51 => 'CL_INVALID_ARG_SIZE',
      -52 => 'CL_INVALID_KERNEL_ARGS',
      -53 => 'CL_INVALID_WORK_DIMENSION',
      -54 => 'CL_INVALID_WORK_GROUP_SIZE',
      -55 => 'CL_INVALID_WORK_ITEM_SIZE',
      -56 => 'CL_INVALID_GLOBAL_OFFSET',
      -57 => 'CL_INVALID_EVENT_WAIT_LIST',
      -58 => 'CL_INVALID_EVENT',
      -59 => 'CL_INVALID_OPERATION',
      -60 => 'CL_INVALID_GL_OBJECT',
      -61 => 'CL_INVALID_BUFFER_SIZE',
      -62 => 'CL_INVALID_MIP_LEVEL',
      -63 => 'CL_INVALID_GLOBAL_WORK_SIZE',
      -64 => 'CL_INVALID_PROPERTY'
    }

    def self.buffer
      FFI::MemoryPointer.new FFI::OpenCL.find_type(:cl_int)
    end

    def self.check!(code, message = '')
      code = code.read_int32 if code.respond_to?(:read_int32)
      puts code
      return if code == CL_SUCCESS
      raise RuntimeError, "#{MAP[code]}: #{message}"
    end
  end
end
