require 'net/ftp'
module EasyDownloader
  module Ftp
    def ftp_download(options)
      open_ftp do |ftp|

        change_remote_dir(ftp)

        files = ftp.nlst.select {|file_name| options.remote_pattern == '*' || file_name =~ Regexp.new(options.remote_pattern) }
        total = files.size
        options.result.found(files.size, files)

        files.each do |path|
          options.result.starting_path(path)
          ftp.get(path, "#{options.local_path}#{path}")
          options.load_count = options.load_count + 1
          options.result.finished_path(path)
          options.result.files_downloaded << "#{options.local_path}#{path}"
        end
      end
    end

    def ftp_upload(options)
      open_ftp do |ftp|

        change_remote_dir(ftp)

        files = Dir[options.remote_path, options.remote_pattern]
        options.result.found(files.size, files.map(&:name))

        files.each do |path|
          options.result.starting_path(path)
          if options.remote_file
            ftp.put(path, options.remote_file)
            options.result.files_downloaded << options.remote_file
          else
            ftp.put(path)
            options.result.files_downloaded << File.basename(path)
          end
          options.load_count= options.load_count + 1
          options.result.finished_path(path)
        end
      end
    end

    def open_ftp(&block)
      Net::FTP.open(options.host,
                    options.user,
                    ftp_password_option(options.password)) do |ftp|
        yield(ftp)
      end
    end

    def change_remote_dir(ftp)
      if options.remote_path
        begin
          ftp.chdir(options.remote_path)
        rescue InvalidRemoteDirectory
        end
      end
    end

    def ftp_password_option(password)
      password ? password : nil
    end
  end
end
