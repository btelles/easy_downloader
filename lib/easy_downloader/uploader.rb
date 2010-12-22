module EasyDownloader
  class Uploader < AbstractLoader

    private

    self.load_type='upload'

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
