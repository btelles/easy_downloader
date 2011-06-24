module EasyDownloader
  module Sftp
    def sftp_download(options)
      Net::SFTP.start(options.host,
                      options.user,
                      sftp_password_option(options.password)) do |sftp|

        files = sftp.dir.glob(options.remote_path, options.remote_pattern)
        options.result.found(files.size, files.map(&:name))

        files.map(&:name).each do |path|
          options.result.starting_path(path)
          options.load_count += 1 if sftp.download!("#{options.remote_path}#{path}", "#{options.local_path}#{path}")
          options.result.finished_path(path)
          options.result.files_downloaded << "#{options.local_path}#{path}"
        end
      end
    end

    def sftp_password_option(password)
      password ?
        {:password => password} :
        Hash.new
    end
  end
end
