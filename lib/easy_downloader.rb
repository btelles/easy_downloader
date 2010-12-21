require 'easy_downloader/result'
require 'easy_downloader/options'
require 'easy_downloader/sftp_downloader'
require 'easy_downloader/ftp_downloader'
require 'easy_downloader/http_downloader'
require 'net/sftp'
module EasyDownloader

  def self.download(*options)
    Downloader.new(*options)
  end

  class Downloader
    attr_reader :files, :result

    include SftpDownloader
    include FtpDownloader
    include HttpDownloader


    # Set up and immediately download files. The object has only two attributes:
    #   1. result
    #   2. files
    #
    #  @param [Hash, #options] options to use including host, password, source, and destination directories.%
    #    The available keys are:
    #
    #    :type =>  (required) The protocal used to download the file. One of :sftp, :ftp or :http.
    #    :host =>  (required) the domain of the remote server (source)
    #    :remote_path => a relative path to "cd" into when we first access the remote server
    #    :remote_pattern => a glob pattern that will select only the files we want to download.%
    #       see Ruby's core API if you are not familiar with this concept.
    #    :user =>  a username or login used for authenticating on the server
    #    :password =>  a password that, in combination with the user, will grant access to the remote server/host
    def initialize(*options)
      @options= Options.new(*options)
      download
    end

    private

    def download
      begin
        case @options[:type].to_sym
        when :ftp
          ftp_download(@options)
        when :http
          http_download(@options)
        when :sftp
          sftp_download(@options)
        end

      rescue
        @result.errors= <<-ERROR_MESSAGE
  There was a problem downloading from #{@options[:host]}.
  The error we got was:
      #{$ERROR_INFO.inspect}
      #{$ERROR_INFO.message}
  We tried connecting with:
  host: #{@options[:host]}
  user: #{@options[:user]}
  pass: [filtered]
  directory_path: #{@options[:remote_path]}
  file_pattern: #{@options[:remote_pattern]}
  destination: #{@destination_dir}
        ERROR_MESSAGE
      end
    end
  end
end
