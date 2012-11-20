module Heikou
  class CL
    include FFI::OpenCL

    def self.create
      cl = new

      if block_given?
        begin
          yield cl
        ensure
          cl.finalize
        end
      else
        cl
      end
    end

    def initialize
      clear
    end

    def finalize
      @buffers.each(&:finalize)
      @programs.each(&:finalize)
      @queues.each(&:finalize)
      @contexts.each(&:finalize)
    end

    def platforms
      return @platforms unless @platforms.empty?
      @platforms = Platform.all(self)
    end

    def default_platform
      platforms.first
    end

    def devices
      return @devices unless @devices.empty?
      @devices = Device.all(self)
    end

    def default_device
      devices.first
    end

    def contexts
      return @contexts unless @contexts.empty?
      @contexts = [Context.new(self, default_device)]
    end

    def default_context
      contexts.first
    end

    def create_program_with_source(source = nil)
      source ||= yield
      program = Program.new(self, default_context, source)
      @programs << program
      program
    end

    def queues
      return @queues unless @queues.empty?
      @queues = [Queue.new(self, default_context, default_device)]
    end

    def default_queue
      queues.first
    end

    def create_buffer(type, size, options = CL_MEM_WRITE_ONLY)
      buffer = Buffer.new(self, default_context, options, type, size)
      @buffers << buffer
      buffer
    end

    private

    def clear
      @platforms = []
      @devices = []
      @buffers = []
      @programs = []
      @queues = []
      @contexts = []
    end
  end
end
