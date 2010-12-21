require 'net/ftp'
module EasyDownloader
  module FtpDownloader
    def ftp_download(options)
      result = options.result
      result.started
      Net::FTP.open(options.host,
                    options.user,
                    ftp_password_option(options.password)) do |ftp|

        files = ftp.dir.glob(options.remote_path, options.remote_pattern)
        total = files.size
        result.found(files.size, files.map(&:name))

        files.map(&:name).each do |path|
          result.starting_path(path)
          download_count += 1 if ftp.download!("#{options.remote_path}#{path}", "#{options.local_path}#{path}")
          result.finished_path(path)
          files_downloaded << "#{options.locas_path}#{path}"
        end
      end

      result.downloaded(download_count)
      result.finished
    end

    def ftp_password_option(password)
      password ? password : nil
    end
  end
end
