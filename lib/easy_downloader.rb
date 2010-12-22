require 'active_support'
require 'active_support/core_ext'
require 'easy_downloader/result'
require 'easy_downloader/options'
require 'easy_downloader/sftp'
require 'easy_downloader/ftp'
require 'easy_downloader/http'
require 'easy_downloader/abstract_loader'
require 'easy_downloader/downloader'
require 'easy_downloader/uploader'
require 'net/sftp'
module EasyDownloader

  class InvalidRemoteDirectory < Exception; end

  def self.download(*options)
    Downloader.new(*options).execute
  end

  def self.upload(*options)
    Uploader.new(*options).execute
  end

end
