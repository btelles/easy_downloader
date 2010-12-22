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
        directory_path: #{options.remote_path}
        file_pattern: #{options.remote_pattern}
        destination: #{options.local_path}
              ERROR_MESSAGE
      message
    end
  end
end
