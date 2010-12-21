require 'net/ftp'
module EasyDownloader
  module FtpDownloader
    def ftp_download(options)
      download_count = options.download_count
      result = options.result
      result.started
      Net::FTP.open(options.host,
                    options.user,
                    ftp_password_option(options.password)) do |ftp|

        begin
          ftp.chdir(options.remote_path) 
        rescue InvalidRemoteDirectory
        end

        files = ftp.nlst.select {|file_name| options.remote_pattern == '*' || file_name =~ Regexp.new(options.remote_pattern) }
        puts files.join("\n")
        total = files.size
        result.found(files.size, files)

        files.each do |path|
          result.starting_path(path)
          ftp.get(path, "#{options.local_path}#{path}")
          download_count += 1 
          result.finished_path(path)
          result.files_downloaded << "#{options.local_path}#{path}"
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
