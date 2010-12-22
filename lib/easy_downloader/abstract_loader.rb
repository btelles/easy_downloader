module EasyDownloader
  class AbstractLoader

    attr_reader :files, :result

    include Sftp
    include Ftp
    include Http

    def initialize(*options)
      @options= Options.new(*options)
    end

    def execute
      begin
        @options.result.started
        execute_load
        @options.result.loaded(@options.load_count)
        @options.result.finished
      rescue Exception => e
        @options.result.errors= error_message(@options, e)
      end
      @result = @options.result
      @files  = @result.loaded
      self
    end

    private

    def execute_load
      raise NotImplementedError.new("#{self.class.name} does not have an 'execute_load' method.")
    end

    def error_message(options, e)
      raise NotImplementedError.new("#{self.class.name} does not have an 'error_message' method.")
    end
  end
end
