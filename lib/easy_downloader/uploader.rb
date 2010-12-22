module EasyDownloader
  class Uploader < AbstractLoader

    private

    def execute_load
      [:ftp, :http, :sftp].include?(@options.type) ?
        send("#{@options.type.to_s}_upload".to_sym, @options) :
        raise(NotImplementedError.new("we don't have an uploader of this type."))
    end

    def error_message(options, e)
      message = <<-ERROR_MESSAGE
        There was a problem uploading to #{options.host}.
        The error we got was:
            #{e.message}
            #{e.backtrace.inspect}
        We tried connecting with:
        host: #{options.host}
        user: #{options.user}
        pass: [filtered]
        source: #{options.local_path}
        remote directory path: #{options.remote_path}
        remote file pattern: #{options.remote_pattern}
              ERROR_MESSAGE
      message
    end
  end
end
