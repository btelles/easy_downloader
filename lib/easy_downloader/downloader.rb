module EasyDownloader
  class Downloader < AbstractLoader

    private

    self.load_type= 'download'

    def error_message(options, e)
      message = <<-ERROR_MESSAGE
        There was a problem downloading from #{options.host}.
        The error we got was:
            #{e.message}
            #{e.backtrace.inspect}
        We tried connecting with:
        host: #{options.host}
        user: #{options.user}
        pass: [filtered]
        remote_file:    #{options.remote_file}
        remote_path:    #{options.remote_path}
        remote_pattern: #{options.remote_pattern}
        local_path:     #{options.local_path}
        local_file:     #{options.local_file}
              ERROR_MESSAGE
      message
    end
  end
end
