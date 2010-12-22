module EasyDownloader
  module Http
    def http_download(options)
      #result = options.result
      #result.started
      #Net::SFTP.start(options.host,
      #                options.user,
      #                password_option(options.password)) do |sftp|

      #  files = sftp.dir.glob(options.remote_path, options.remote_pattern)
      #  total = files.size
      #  result.found(files.size, files.map(&:name))

      #  files.map(&:name).each do |path|
      #    result.starting_path(path)
      #    download_count += 1 if sftp.download!("#{options.remote_path}#{path}", "#{options.destination_dir}#{path}")
      #    result.finished_path(path)
      #    files_downloaded << "#{options.destination_dir}#{path}"
      #  end
      #end

      #result.downloaded(download_count)
      #result.finished
    end

    def password_option(password)
      password ?
        {:password => password} :
        Hash.new
    end
  end
end
