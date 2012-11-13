module FFI
  module OpenCL
    extend FFI::Library

    ffi_lib '/System/Library/Frameworks/OpenCL.framework/OpenCL'

    typedef :int32, :cl_int
    typedef :uint32, :cl_uint
    typedef :uint64, :cl_ulong

    typedef :pointer, :cl_platform_id
    typedef :pointer, :cl_device_id
    typedef :pointer, :cl_context
    typedef :pointer, :cl_command_queue
    typedef :pointer, :cl_mem
    typedef :pointer, :cl_program
    typedef :pointer, :cl_kernel
    typedef :pointer, :cl_event
    typedef :pointer, :cl_sampler

    typedef :cl_uint, :cl_bool
    typedef :cl_ulong, :cl_bitfield
    typedef :cl_bitfield, :cl_device_type
    typedef :cl_uint, :cl_platform_info
    typedef :cl_uint, :cl_device_info
    typedef :cl_bitfield, :cl_device_fp_config
    typedef :cl_uint, :cl_device_mem_cache_type
    typedef :cl_uint, :cl_device_local_mem_type
    typedef :cl_bitfield, :cl_device_exec_capabilities
    typedef :cl_bitfield, :cl_command_queue_properties

    typedef :cl_uint, :cl_context_info
    typedef :cl_bitfield, :cl_mem_flags

    # error codes

    # OpenCL version
    CL_VERSION_1_0 = 1
    CL_VERSION_1_1 = 1

    # cl_bool
    CL_FALSE = 0
    CL_TRUE = 1
    CL_BLOCKING = CL_TRUE
    CL_NON_BLOCKING = CL_FALSE

    # cl_platform_info
    CL_PLATFORM_PROFILE = 0x0900
    CL_PLATFORM_VERSION = 0x0901
    CL_PLATFORM_NAME = 0x0902
    CL_PLATFORM_VENDOR = 0x0903
    CL_PLATFORM_EXTENSIONS = 0x0904

    # cl_device_type - bitfield
    CL_DEVICE_TYPE_DEFAULT = 1 << 0
    CL_DEVICE_TYPE_CPU = 1 << 1
    CL_DEVICE_TYPE_GPU = 1 << 2
    CL_DEVICE_TYPE_ACCELERATOR = 1 << 3
    CL_DEVICE_TYPE_ALL = 0xffffffff

    # cl_device_info
    CL_DEVICE_NAME = 0x102b

    # cl_device_fp_config - bitfield

    # cl_device_mem_cache_type

    # cl_device_local_mem_type

    # cl_device_exec_capabilities - bitfield

    # cl_command_queue_properties - bitfield
    CL_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE = 1 << 0
    CL_QUEUE_PROFILING_ENABLE = 1 << 1

    # cl_context_info
    CL_CONTEXT_REFERENCE_COUNT = 0x1080
    CL_CONTEXT_DEVICES = 0x1081
    CL_CONTEXT_PROPERTIES = 0x1082
    CL_CONTEXT_NUM_DEVICES = 0x1083

    # cl_context_info + cl_context_properties

    # cl_command_queue_info

    # cl_mem_flags - bitfield
    CL_MEM_READ_WRITE = 1 << 0
    CL_MEM_WRITE_ONLY = 1 << 1
    CL_MEM_READ_ONLY = 1 << 2
    CL_MEM_USE_HOST_PTR = 1 << 3
    CL_MEM_ALLOC_HOST_PTR = 1 << 4
    CL_MEM_COPY_HOST_PTR = 1 << 5

    # cl_channel_order

    # cl_channel_type

    # cl_mem_object_type

    # cl_mem_info

    # cl_image_info

    # cl_addressing_mode

    # cl_filter_mode

    # cl_sampler_info

    # cl_map_flags - bitfield

    # cl_program_info

    # cl_program_build_info

    # cl_build_status

    # cl_kernel_info

    # cl_kernel_work_group_info

    # cl_event_info

    # cl_command_type

    # command execution status

    # cl_buffer_create_type

    # cl_profiling_info

    # platform API
    attach_function :clGetPlatformIDs, [:cl_uint, :pointer, :pointer], :cl_int
    attach_function :clGetPlatformInfo, [:cl_platform_id, :cl_platform_info, :size_t, :pointer, :pointer], :cl_int

    # device API
    attach_function :clGetDeviceIDs, [:cl_platform_id, :cl_device_type, :cl_uint, :pointer, :pointer], :cl_int
    attach_function :clGetDeviceInfo, [:cl_device_id, :cl_device_info, :size_t, :pointer, :pointer], :cl_int

    # context API
    attach_function :clCreateContext, [:pointer, :cl_uint, :pointer, :pointer, :pointer, :pointer], :cl_context
    attach_function :clRetainContext, [:cl_context], :cl_int
    attach_function :clReleaseContext, [:cl_context], :cl_int
    attach_function :clGetContextInfo, [:cl_context, :cl_context_info, :size_t, :pointer, :pointer], :cl_int

    # command queue API
    attach_function :clCreateCommandQueue, [:cl_context, :cl_device_id, :cl_command_queue_properties, :pointer], :cl_command_queue
    attach_function :clReleaseCommandQueue, [:cl_command_queue], :cl_int

    # memory object API
    attach_function :clCreateBuffer, [:cl_context, :cl_mem_flags, :size_t, :pointer, :pointer], :cl_mem 
    attach_function :clReleaseMemObject, [:cl_mem], :cl_int

    # sampler API

    # program object API
    attach_function :clCreateProgramWithSource, [:cl_context, :cl_uint, :pointer, :pointer, :pointer], :cl_program
    attach_function :clReleaseProgram, [:cl_program], :cl_int
    attach_function :clBuildProgram, [:cl_program, :cl_uint, :pointer, :string, :pointer, :pointer], :cl_int

    # kernel object API
    attach_function :clCreateKernel, [:cl_program, :string, :pointer], :cl_kernel
    attach_function :clReleaseKernel, [:cl_kernel], :cl_int
    attach_function :clSetKernelArg, [:cl_kernel, :cl_uint, :size_t, :pointer], :cl_int

    # event object API

    # profiling API

    # flush and finish API
    attach_function :clFinish, [:cl_command_queue], :cl_int

    # enqueued command API
    attach_function :clEnqueueReadBuffer, [:cl_command_queue, :cl_mem, :cl_bool, :size_t, :size_t, :pointer, :cl_uint, :pointer, :pointer], :cl_int
    attach_function :clEnqueueNDRangeKernel, [:cl_command_queue, :cl_kernel, :cl_uint, :pointer, :pointer, :pointer, :cl_uint, :pointer, :pointer], :cl_int
  end
end
