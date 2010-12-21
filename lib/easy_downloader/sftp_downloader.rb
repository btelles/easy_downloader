module EasyDownloader
  module SftpDownloader
    def sftp_download(options)
      result = options.result
      result.started

      Net::SFTP.start(options.host,
                      options.user,
                      sftp_password_option(options.password)) do |sftp|

        files = sftp.dir.glob(options.remote_path, options.remote_pattern)
        total = files.size
        result.found(files.size, files.map(&:name))

        files.map(&:name).each do |path|
          result.starting_path(path)
          options.download_count += 1 if sftp.download!("#{options.remote_path}#{path}", "#{options.local_path}#{path}")
          result.finished_path(path)
          result.files_downloaded << "#{options.local_path}#{path}"
        end
      end

      result.downloaded(options.download_count)
      result.finished
    end

    def sftp_password_option(password)
      password ?
        {:password => password} :
        Hash.new
    end
  end
end
