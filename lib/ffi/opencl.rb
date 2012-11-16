module FFI
  module OpenCL
    extend FFI::Library

    if FFI::Platform.mac?
      ffi_lib '/System/Library/Frameworks/OpenCL.framework/OpenCL'
    else
      ffi_lib 'OpenCL'
    end

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

    #typedef :intptr_t, :cl_context_properties
    typedef :pointer, :cl_context_properties
    typedef :cl_uint, :cl_context_info
    typedef :cl_uint, :cl_command_queue_info
    typedef :cl_uint, :cl_channel_order
    typedef :cl_uint, :cl_channel_type
    typedef :cl_bitfield, :cl_mem_flags
    typedef :cl_uint, :cl_mem_object_type
    typedef :cl_uint, :cl_mem_info
    typedef :cl_uint, :cl_image_info
    typedef :cl_uint, :cl_buffer_create_type
    typedef :cl_uint, :cl_addressing_mode
    typedef :cl_uint, :cl_filter_mode
    typedef :cl_uint, :cl_sampler_info
    typedef :cl_bitfield, :cl_map_flags
    typedef :cl_uint, :cl_program_info
    typedef :cl_uint, :cl_program_build_info
    typedef :cl_int, :cl_build_status
    typedef :cl_uint, :cl_kernel_info
    typedef :cl_uint, :cl_kernel_work_group_info
    typedef :cl_uint, :cl_event_info
    typedef :cl_uint, :cl_command_type
    typedef :cl_uint, :cl_profiling_info

    class CLImageFormat < Struct
      layout :image_channel_order, :cl_channel_order,
             :image_channel_data_type, :cl_channel_type
    end

    class CLBufferRegion < Struct
      layout :origin, :size_t,
             :size, :size_t
    end

    # error codes
    CL_SUCCESS = 0
    CL_DEVICE_NOT_FOUND = -1
    CL_DEVICE_NOT_AVAILABLE = -2
    CL_COMPILER_NOT_AVAILABLE = -3
    CL_MEM_OBJECT_ALLOCATION_FAILURE = -4
    CL_OUT_OF_RESOURCES = -5
    CL_OUT_OF_HOST_MEMORY = -6
    CL_PROFILING_INFO_NOT_AVAILABLE = -7
    CL_MEM_COPY_OVERLAP = -8
    CL_IMAGE_FORMAT_MISMATCH = -9
    CL_IMAGE_FORMAT_NOT_SUPPORTED = -10
    CL_BUILD_PROGRAM_FAILURE = -11
    CL_MAP_FAILURE = -12
    CL_MISALIGNED_SUB_BUFFER_OFFSET = -13
    CL_EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST = -14

    CL_INVALID_VALUE = -30
    CL_INVALID_DEVICE_TYPE = -31
    CL_INVALID_PLATFORM = -32
    CL_INVALID_DEVICE = -33
    CL_INVALID_CONTEXT = -34
    CL_INVALID_QUEUE_PROPERTIES = -35
    CL_INVALID_COMMAND_QUEUE = -36
    CL_INVALID_HOST_PTR = -37
    CL_INVALID_MEM_OBJECT = -38
    CL_INVALID_IMAGE_FORMAT_DESCRIPTOR = -39
    CL_INVALID_IMAGE_SIZE = -40
    CL_INVALID_SAMPLER = -41
    CL_INVALID_BINARY = -42
    CL_INVALID_BUILD_OPTIONS = -43
    CL_INVALID_PROGRAM = -44
    CL_INVALID_PROGRAM_EXECUTABLE = -45
    CL_INVALID_KERNEL_NAME = -46
    CL_INVALID_KERNEL_DEFINITION = -47
    CL_INVALID_KERNEL = -48
    CL_INVALID_ARG_INDEX = -49
    CL_INVALID_ARG_VALUE = -50
    CL_INVALID_ARG_SIZE = -51
    CL_INVALID_KERNEL_ARGS = -52
    CL_INVALID_WORK_DIMENSION = -53
    CL_INVALID_WORK_GROUP_SIZE = -54
    CL_INVALID_WORK_ITEM_SIZE = -55
    CL_INVALID_GLOBAL_OFFSET = -56
    CL_INVALID_EVENT_WAIT_LIST = -57
    CL_INVALID_EVENT = -58
    CL_INVALID_OPERATION = -59
    CL_INVALID_GL_OBJECT = -60
    CL_INVALID_BUFFER_SIZE = -61
    CL_INVALID_MIP_LEVEL = -62
    CL_INVALID_GLOBAL_WORK_SIZE = -63
    CL_INVALID_PROPERTY = -64

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
    CL_DEVICE_TYPE = 0x1000
    CL_DEVICE_VENDOR_ID = 0x1001
    CL_DEVICE_MAX_COMPUTE_UNITS = 0x1002
    CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS = 0x1003
    CL_DEVICE_MAX_WORK_GROUP_SIZE = 0x1004
    CL_DEVICE_MAX_WORK_ITEM_SIZES = 0x1005
    CL_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR = 0x1006
    CL_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT = 0x1007
    CL_DEVICE_PREFERRED_VECTOR_WIDTH_INT = 0x1008
    CL_DEVICE_PREFERRED_VECTOR_WIDTH_LONG = 0x1009
    CL_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT = 0x100a
    CL_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE = 0x100b
    CL_DEVICE_MAX_CLOCK_FREQUENCY = 0x100c
    CL_DEVICE_ADDRESS_BITS = 0x100d
    CL_DEVICE_MAX_READ_IMAGE_ARGS = 0x100e
    CL_DEVICE_MAX_WRITE_IMAGE_ARGS = 0x100f
    CL_DEVICE_MAX_MEM_ALLOC_SIZE = 0x1010
    CL_DEVICE_IMAGE2D_MAX_WIDTH = 0x1011
    CL_DEVICE_IMAGE2D_MAX_HEIGHT = 0x1012
    CL_DEVICE_IMAGE3D_MAX_WIDTH = 0x1013
    CL_DEVICE_IMAGE3D_MAX_HEIGHT = 0x1014
    CL_DEVICE_IMAGE3D_MAX_DEPTH = 0x1015
    CL_DEVICE_IMAGE_SUPPORT = 0x1016
    CL_DEVICE_MAX_PARAMETER_SIZE = 0x1017
    CL_DEVICE_MAX_SAMPLERS = 0x1018
    CL_DEVICE_MEM_BASE_ADDR_ALIGN = 0x1019
    CL_DEVICE_MIN_DATA_TYPE_ALIGN_SIZE = 0x101a
    CL_DEVICE_SINGLE_FP_CONFIG = 0x101b
    CL_DEVICE_GLOBAL_MEM_CACHE_TYPE = 0x101c
    CL_DEVICE_GLOBAL_MEM_CACHELINE_SIZE = 0x101d
    CL_DEVICE_GLOBAL_MEM_CACHE_SIZE = 0x101e
    CL_DEVICE_GLOBAL_MEM_SIZE = 0x101f
    CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE = 0x1020
    CL_DEVICE_MAX_CONSTANT_ARGS = 0x1021
    CL_DEVICE_LOCAL_MEM_TYPE = 0x1022
    CL_DEVICE_LOCAL_MEM_SIZE = 0x1023
    CL_DEVICE_ERROR_CORRECTION_SUPPORT = 0x1024
    CL_DEVICE_PROFILING_TIMER_RESOLUTION = 0x1025
    CL_DEVICE_ENDIAN_LITTLE = 0x1026
    CL_DEVICE_AVAILABLE = 0x1027
    CL_DEVICE_COMPILER_AVAILABLE = 0x1028
    CL_DEVICE_EXECUTION_CAPABILITIES = 0x1029
    CL_DEVICE_QUEUE_PROPERTIES = 0x102a
    CL_DEVICE_NAME = 0x102b
    CL_DEVICE_VENDOR = 0x102c
    CL_DRIVER_VERSION = 0x102d
    CL_DEVICE_PROFILE = 0x102e
    CL_DEVICE_VERSION = 0x102f
    CL_DEVICE_EXTENSIONS = 0x1030
    CL_DEVICE_PLATFORM = 0x1031
    #CL_DEVICE_DOUBLE_FP_CONFIG = 0x1032 # reserved
    #CL_DEVICE_HALF_FP_CONFIG = 0x1033 # reserved
    CL_DEVICE_PREFERRED_VECTOR_WIDTH_HALF = 0x1034
    CL_DEVICE_HOST_UNIFIED_MEMORY = 0x1035
    CL_DEVICE_NATIVE_VECTOR_WIDTH_CHAR = 0x1036
    CL_DEVICE_NATIVE_VECTOR_WIDTH_SHORT = 0x1037
    CL_DEVICE_NATIVE_VECTOR_WIDTH_INT = 0x1038
    CL_DEVICE_NATIVE_VECTOR_WIDTH_LONG = 0x1039
    CL_DEVICE_NATIVE_VECTOR_WIDTH_FLOAT = 0x103a
    CL_DEVICE_NATIVE_VECTOR_WIDTH_DOUBLE = 0x103b
    CL_DEVICE_NATIVE_VECTOR_WIDTH_HALF = 0x103c
    CL_DEVICE_OPENCL_C_VERSION = 0x103d

    # cl_device_fp_config - bitfield
    CL_FP_DENORM = 1 << 0
    CL_FP_INF_NAN = 1 << 1
    CL_FP_ROUND_TO_NEAREST = 1 << 2
    CL_FP_ROUND_TO_ZERO = 1 << 3
    CL_FP_ROUND_TO_INF = 1 << 4
    CL_FP_FMA = 1 << 5
    CL_FP_SOFT_FLOAT = 1 << 6

    # cl_device_mem_cache_type
    CL_NONE = 0x0
    CL_READ_ONLY_CACHE = 0x1
    CL_READ_WRITE_CACHE = 0x2

    # cl_device_local_mem_type
    CL_LOCAL = 0x1
    CL_GLOBAL = 0x2

    # cl_device_exec_capabilities - bitfield
    CL_EXEC_KERNEL = 1 << 0
    CL_EXEC_NATIVE_KERNEL = 1 << 1

    # cl_command_queue_properties - bitfield
    CL_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE = 1 << 0
    CL_QUEUE_PROFILING_ENABLE = 1 << 1

    # cl_context_info
    CL_CONTEXT_REFERENCE_COUNT = 0x1080
    CL_CONTEXT_DEVICES = 0x1081
    CL_CONTEXT_PROPERTIES = 0x1082
    CL_CONTEXT_NUM_DEVICES = 0x1083

    # cl_context_info + cl_context_properties
    CL_CONTEXT_PLATFORM = 0x1084

    # cl_command_queue_info
    CL_QUEUE_CONTEXT = 0x1090
    CL_QUEUE_DEVICE = 0x1091
    CL_QUEUE_REFERENCE_COUNT = 0x1092
    CL_QUEUE_PROPERTIES = 0x1093

    # cl_mem_flags - bitfield
    CL_MEM_READ_WRITE = 1 << 0
    CL_MEM_WRITE_ONLY = 1 << 1
    CL_MEM_READ_ONLY = 1 << 2
    CL_MEM_USE_HOST_PTR = 1 << 3
    CL_MEM_ALLOC_HOST_PTR = 1 << 4
    CL_MEM_COPY_HOST_PTR = 1 << 5

    # cl_channel_order
    CL_R = 0x10b0
    CL_A = 0x10b1
    CL_RG = 0x10b2
    CL_RA = 0x10b3
    CL_RGB = 0x10b4
    CL_RGBA = 0x10b5
    CL_BGRA = 0x10b6
    CL_ARGB = 0x10b7
    CL_INTENSITY = 0x10b8
    CL_LUMINANCE = 0x10b9
    CL_Rx = 0x10ba
    CL_RGx = 0x10bb
    CL_RGBx = 0x10bc

    # cl_channel_type
    CL_SNORM_INT8 = 0x10d0
    CL_SNORM_INT16 = 0x10d1
    CL_UNORM_INT8 = 0x10d2
    CL_UNORM_INT16 = 0x10d3
    CL_UNORM_SHORT_565 = 0x10d4
    CL_UNORM_SHORT_555 = 0x10d5
    CL_UNORM_INT_101010 = 0x10d6
    CL_SIGNED_INT8 = 0x10d7
    CL_SIGNED_INT16 = 0x10d8
    CL_SIGNED_INT32 = 0x10d9
    CL_UNSIGNED_INT8 = 0x10da
    CL_UNSIGNED_INT16 = 0x10db
    CL_UNSIGNED_INT32 = 0x10dc
    CL_HALF_FLOAT = 0x10dd
    CL_FLOAT = 0x10de

    # cl_mem_object_type
    CL_MEM_OBJECT_BUFFER = 0x10f0
    CL_MEM_OBJECT_IMAGE2D = 0x10f1
    CL_MEM_OBJECT_IMAGE3D = 0x10f2

    # cl_mem_info
    CL_MEM_TYPE = 0x1100
    CL_MEM_FLAGS = 0x1101
    CL_MEM_SIZE = 0x1102
    CL_MEM_HOST_PTR = 0x1103
    CL_MEM_MAP_COUNT = 0x1104
    CL_MEM_REFERENCE_COUNT = 0x1105
    CL_MEM_CONTEXT = 0x1106
    CL_MEM_ASSOCIATED_MEMOBJECT = 0x1107
    CL_MEM_OFFSET = 0x1108

    # cl_image_info
    CL_IMAGE_FORMAT = 0x1110
    CL_IMAGE_ELEMENT_SIZE = 0x1111
    CL_IMAGE_ROW_PITCH = 0x1112
    CL_IMAGE_SLICE_PITCH = 0x1113
    CL_IMAGE_WIDTH = 0x1114
    CL_IMAGE_HEIGHT = 0x1115
    CL_IMAGE_DEPTH = 0x1116

    # cl_addressing_mode
    CL_ADDRESS_NONE = 0x1130
    CL_ADDRESS_CLAMP_TO_EDGE = 0x1131
    CL_ADDRESS_CLAMP = 0x1132
    CL_ADDRESS_REPEAT = 0x1133
    CL_ADDRESS_MIRRORED_REPEAT = 0x1134

    # cl_filter_mode
    CL_FILTER_NEAREST = 0x1140
    CL_FILTER_LINEAR = 0x1141

    # cl_sampler_info
    CL_SAMPLER_REFERENCE_COUNT = 0x1150
    CL_SAMPLER_CONTEXT = 0x1151
    CL_SAMPLER_NORMALIZED_COORDS = 0x1152
    CL_SAMPLER_ADDRESSING_MODE = 0x1153
    CL_SAMPLER_FILTER_MODE = 0x1154

    # cl_map_flags - bitfield
    CL_MAP_READ = 1 << 0
    CL_MAP_WRITE = 1 << 1

    # cl_program_info
    CL_PROGRAM_REFERENCE_COUNT = 0x1160
    CL_PROGRAM_CONTEXT = 0x1161
    CL_PROGRAM_NUM_DEVICES = 0x1162
    CL_PROGRAM_DEVICES = 0x1163
    CL_PROGRAM_SOURCE = 0x1164
    CL_PROGRAM_BINARY_SIZES = 0x1165
    CL_PROGRAM_BINARIES = 0x1166

    # cl_program_build_info
    CL_PROGRAM_BUILD_STATUS = 0x1181
    CL_PROGRAM_BUILD_OPTIONS = 0x1182
    CL_PROGRAM_BUILD_LOG = 0x1183

    # cl_build_status
    CL_BUILD_SUCCESS = 0
    CL_BUILD_NONE = -1
    CL_BUILD_ERROR = -2
    CL_BUILD_IN_PROGRESS = -3

    # cl_kernel_info
    CL_KERNEL_FUNCTION_NAME = 0x1190
    CL_KERNEL_NUM_ARGS = 0x1191
    CL_KERNEL_REFERENCE_COUNT = 0x1192
    CL_KERNEL_CONTEXT = 0x1193
    CL_KERNEL_PROGRAM = 0x1194

    # cl_kernel_work_group_info
    CL_KERNEL_WORK_GROUP_SIZE = 0x11b0
    CL_KERNEL_COMPILE_WORK_GROUP_SIZE = 0x11b1
    CL_KERNEL_LOCAL_MEM_SIZE = 0x11b2
    CL_KERNEL_PREFERRED_WORK_GROUP_SIZE_MULTIPLE = 0x11b3
    CL_KERNEL_PRIVATE_MEM_SIZE = 0x11b4

    # cl_event_info
    CL_EVENT_COMMAND_QUEUE = 0x11d0
    CL_EVENT_COMMAND_TYPE = 0x11d1
    CL_EVENT_REFERENCE_COUNT = 0x11d2
    CL_EVENT_COMMAND_EXECUTION_STATUS = 0x11d3
    CL_EVENT_CONTEXT = 0x11d4

    # cl_command_type
    CL_COMMAND_NDRANGE_KERNEL = 0x11f0
    CL_COMMAND_TASK = 0x11f1
    CL_COMMAND_NATIVE_KERNEL = 0x11f2
    CL_COMMAND_READ_BUFFER = 0x11f3
    CL_COMMAND_WRITE_BUFFER = 0x11f4
    CL_COMMAND_COPY_BUFFER = 0x11f5
    CL_COMMAND_READ_IMAGE = 0x11f6
    CL_COMMAND_WRITE_IMAGE = 0x11f7
    CL_COMMAND_COPY_IMAGE = 0x11f8
    CL_COMMAND_COPY_IMAGE_TO_BUFFER = 0x11f9
    CL_COMMAND_COPY_BUFFER_TO_IMAGE = 0x11fa
    CL_COMMAND_MAP_BUFFER = 0x11fb
    CL_COMMAND_MAP_IMAGE = 0x11fc
    CL_COMMAND_UNMAP_MEM_OBJECT = 0x11fd
    CL_COMMAND_MARKER = 0x11fe
    CL_COMMAND_ACQUIRE_GL_OBJECTS = 0x11ff
    CL_COMMAND_RELEASE_GL_OBJECTS = 0x1200
    CL_COMMAND_READ_BUFFER_RECT = 0x1201
    CL_COMMAND_WRITE_BUFFER_RECT = 0x1202
    CL_COMMAND_COPY_BUFFER_RECT = 0x1203
    CL_COMMAND_USER = 0x1204

    # command execution status
    CL_COMPLETE = 0x0
    CL_RUNNING = 0x1
    CL_SUBMITTED = 0x2
    CL_QUEUED = 0x3

    # cl_buffer_create_type
    CL_BUFFER_CREATE_TYPE_REGION = 0x1220

    # cl_profiling_info
    CL_PROFILING_COMMAND_QUEUED = 0x1280
    CL_PROFILING_COMMAND_SUBMIT = 0x1281
    CL_PROFILING_COMMAND_START = 0x1282
    CL_PROFILING_COMMAND_END = 0x1283

    # platform API
    attach_function :clGetPlatformIDs, [:cl_uint, :pointer, :pointer], :cl_int
    attach_function :clGetPlatformInfo, [:cl_platform_id, :cl_platform_info, :size_t, :pointer, :pointer], :cl_int

    # device API
    attach_function :clGetDeviceIDs, [:cl_platform_id, :cl_device_type, :cl_uint, :pointer, :pointer], :cl_int
    attach_function :clGetDeviceInfo, [:cl_device_id, :cl_device_info, :size_t, :pointer, :pointer], :cl_int

    # context API
    attach_function :clCreateContext, [:pointer, :cl_uint, :pointer, :pointer, :pointer, :pointer], :cl_context
    attach_function :clCreateContextFromType, [:pointer, :cl_uint, :pointer, :pointer, :pointer, :pointer], :cl_context
    attach_function :clRetainContext, [:cl_context], :cl_int
    attach_function :clReleaseContext, [:cl_context], :cl_int
    attach_function :clGetContextInfo, [:cl_context, :cl_context_info, :size_t, :pointer, :pointer], :cl_int

    # command queue API
    attach_function :clCreateCommandQueue, [:cl_context, :cl_device_id, :cl_command_queue_properties, :pointer], :cl_command_queue
    attach_function :clRetainCommandQueue, [:cl_command_queue], :cl_int
    attach_function :clReleaseCommandQueue, [:cl_command_queue], :cl_int
    attach_function :clGetCommandQueueInfo, [:cl_command_queue, :cl_command_queue_info, :size_t, :pointer, :pointer], :cl_int
    attach_function :clSetCommandQueueProperty, [:cl_command_queue, :cl_command_queue_properties, :cl_bool, :pointer], :cl_int # deprecated

    # memory object API
    attach_function :clCreateBuffer, [:cl_context, :cl_mem_flags, :size_t, :pointer, :pointer], :cl_mem 
    attach_function :clCreateSubBuffer, [:cl_mem, :cl_mem_flags, :cl_buffer_create_type, :pointer, :pointer], :cl_mem
    attach_function :clCreateImage2D, [:cl_context, :cl_mem_flags, :pointer, :size_t, :size_t, :size_t, :pointer, :pointer], :cl_mem
    attach_function :clCreateImage3D, [:cl_context, :cl_mem_flags, :pointer, :size_t, :size_t, :size_t, :size_t, :size_t, :pointer, :pointer], :cl_mem
    attach_function :clRetainMemObject, [:cl_mem], :cl_int
    attach_function :clReleaseMemObject, [:cl_mem], :cl_int
    attach_function :clGetSupportedImageFormats, [:cl_context, :cl_mem_flags, :cl_mem_object_type, :cl_uint, :pointer, :pointer], :cl_int
    attach_function :clGetMemObjectInfo, [:cl_mem, :cl_mem_info, :size_t, :pointer, :pointer], :cl_int
    attach_function :clGetImageInfo, [:cl_mem, :cl_image_info, :size_t, :pointer, :pointer], :cl_int
    attach_function :clSetMemObjectDestructorCallback, [:cl_mem, :pointer, :pointer], :cl_int

    # sampler API
    attach_function :clCreateSampler, [:cl_context, :cl_bool, :cl_addressing_mode, :cl_filter_mode, :pointer], :cl_sampler
    attach_function :clRetainSampler, [:cl_sampler], :cl_int
    attach_function :clReleaseSampler, [:cl_sampler], :cl_int
    attach_function :clGetSamplerInfo, [:cl_sampler, :cl_sampler_info, :size_t, :pointer, :pointer], :cl_int

    # program object API
    attach_function :clCreateProgramWithSource, [:cl_context, :cl_uint, :pointer, :pointer, :pointer], :cl_program
    attach_function :clCreateProgramWithBinary, [:cl_context, :cl_uint, :pointer, :pointer, :pointer, :pointer, :pointer], :cl_program
    attach_function :clRetainProgram, [:cl_program], :cl_int
    attach_function :clReleaseProgram, [:cl_program], :cl_int
    attach_function :clBuildProgram, [:cl_program, :cl_uint, :pointer, :string, :pointer, :pointer], :cl_int
    attach_function :clUnloadCompiler, [], :cl_int
    attach_function :clGetProgramInfo, [:cl_program, :cl_program_info, :size_t, :pointer, :pointer], :cl_int
    attach_function :clGetProgramBuildInfo, [:cl_program, :cl_device_id, :cl_program_build_info, :size_t, :pointer, :pointer], :cl_int

    # kernel object API
    attach_function :clCreateKernel, [:cl_program, :string, :pointer], :cl_kernel
    attach_function :clCreateKernelsInProgram, [:cl_program, :cl_uint, :pointer, :pointer], :cl_int
    attach_function :clRetainKernel, [:cl_kernel], :cl_int
    attach_function :clReleaseKernel, [:cl_kernel], :cl_int
    attach_function :clSetKernelArg, [:cl_kernel, :cl_uint, :size_t, :pointer], :cl_int
    attach_function :clGetKernelInfo, [:cl_kernel, :cl_kernel_info, :size_t, :pointer, :pointer], :cl_int
    attach_function :clGetKernelWorkGroupInfo, [:cl_kernel, :cl_device_id, :cl_kernel_work_group_info, :size_t, :pointer, :pointer], :cl_int

    # event object API
    attach_function :clWaitForEvents, [:cl_uint, :pointer], :cl_int
    attach_function :clGetEventInfo, [:cl_event, :cl_event_info, :size_t, :pointer, :pointer], :cl_int
    attach_function :clCreateUserEvent, [:cl_context, :pointer], :cl_event
    attach_function :clRetainEvent, [:cl_event], :cl_int
    attach_function :clReleaseEvent, [:cl_event], :cl_int
    attach_function :clSetUserEventStatus, [:cl_event, :cl_int], :cl_int
    attach_function :clSetEventCallback, [:cl_event, :cl_int, :pointer, :pointer], :cl_int

    # profiling API
    attach_function :clGetEventProfilingInfo, [:cl_event, :cl_profiling_info, :size_t, :pointer, :pointer], :cl_int

    # flush and finish API
    attach_function :clFlush, [:cl_command_queue], :cl_int
    attach_function :clFinish, [:cl_command_queue], :cl_int

    # enqueued command API
    attach_function :clEnqueueReadBuffer, [:cl_command_queue, :cl_mem, :cl_bool, :size_t, :size_t, :pointer, :cl_uint, :pointer, :pointer], :cl_int
    attach_function :clEnqueueReadBufferRect, [:cl_command_queue, :cl_mem, :cl_bool, :pointer, :pointer, :pointer, :size_t, :size_t, :size_t, :size_t, :pointer, :cl_uint, :pointer, :pointer], :cl_int
    attach_function :clEnqueueWriteBuffer, [:cl_command_queue, :cl_mem, :cl_bool, :size_t, :size_t, :pointer, :cl_uint, :pointer, :pointer], :cl_int
    attach_function :clEnqueueWriteBufferRect, [:cl_command_queue, :cl_mem, :cl_bool, :pointer, :pointer, :pointer, :size_t, :size_t, :size_t, :size_t, :pointer, :cl_uint, :pointer, :pointer], :cl_int
    attach_function :clEnqueueCopyBuffer, [:cl_command_queue, :cl_mem, :cl_mem, :size_t, :size_t, :size_t, :cl_uint, :pointer, :pointer], :cl_int
    attach_function :clEnqueueCopyBufferRect, [:cl_command_queue, :cl_mem, :cl_mem, :pointer, :pointer, :pointer, :size_t, :size_t, :size_t, :size_t, :cl_uint, :pointer, :pointer], :cl_int
    attach_function :clEnqueueReadImage, [:cl_command_queue, :cl_mem, :cl_bool, :pointer, :pointer, :size_t, :size_t, :pointer, :cl_uint, :pointer, :pointer], :cl_int
    attach_function :clEnqueueWriteImage, [:cl_command_queue, :cl_mem, :cl_bool, :pointer, :pointer, :size_t, :size_t, :pointer, :cl_uint, :pointer, :pointer], :cl_int
    attach_function :clEnqueueCopyImage, [:cl_command_queue, :cl_mem, :cl_mem, :pointer, :pointer, :pointer, :cl_uint, :pointer, :pointer], :cl_int
    attach_function :clEnqueueCopyImageToBuffer, [:cl_command_queue, :cl_mem, :cl_mem, :pointer, :pointer, :size_t, :cl_uint, :pointer, :pointer], :cl_int
    attach_function :clEnqueueCopyBufferToImage, [:cl_command_queue, :cl_mem, :cl_mem, :size_t, :pointer, :pointer, :cl_uint, :pointer, :pointer], :cl_int
    attach_function :clEnqueueMapBuffer, [:cl_command_queue, :cl_mem, :cl_bool, :cl_map_flags, :size_t, :size_t, :cl_uint, :pointer, :pointer, :pointer], :pointer
    attach_function :clEnqueueMapImage, [:cl_command_queue, :cl_mem, :cl_bool, :cl_map_flags, :pointer, :pointer, :pointer, :pointer, :cl_uint, :pointer, :pointer, :pointer], :pointer
    attach_function :clEnqueueUnmapMemObject, [:cl_command_queue, :cl_mem, :pointer, :cl_uint, :pointer, :pointer], :cl_int
    attach_function :clEnqueueNDRangeKernel, [:cl_command_queue, :cl_kernel, :cl_uint, :pointer, :pointer, :pointer, :cl_uint, :pointer, :pointer], :cl_int
    attach_function :clEnqueueTask, [:cl_command_queue, :cl_kernel, :cl_uint, :pointer, :pointer], :cl_int
    attach_function :clEnqueueNativeKernel, [:cl_command_queue, :pointer, :pointer, :size_t, :cl_uint, :pointer, :pointer, :cl_uint, :pointer, :pointer], :cl_int
    attach_function :clEnqueueMarker, [:cl_command_queue, :pointer], :cl_int
    attach_function :clEnqueueWaitForEvents, [:cl_command_queue, :cl_uint, :pointer], :cl_int
    attach_function :clEnqueueBarrier, [:cl_command_queue], :cl_int

    # extension function access
    attach_function :clGetExtensionFunctionAddress, [:string], :void
  end
end
