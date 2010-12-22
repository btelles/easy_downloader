module EasyDownloader
  class AbstractLoader

    attr_reader :files, :result

    class_attribute :load_type

    include Sftp
    include Ftp
    include Http

    def initialize(*options)
      @options= Options.new(*options)
    end


    def execute_load
      [:ftp, :http, :sftp].include?(@options.type.to_sym) ?
        send("#{@options.type}_#{self.class.load_type.to_s}".to_sym, @options) :
        raise(NotImplementedError.new("we don't have an #{@options.type}er of this type."))
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

    def error_message(options, e)
      raise NotImplementedError.new("#{self.class.name} does not have an 'error_message' method.")
    end

    def local_files_list(options)
      if options.local_file
        [options.local_file]
      else
        Dir[options.local_path, options.local_pattern]
      end
    end

    def options
      @options
    end
  end
end
