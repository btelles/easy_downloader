require 'active_support/core_ext/array/extract_options'
module EasyDownloader
  class Options
    attr_accessor :files, :successful, :result, :download_count,
                  :host, :user, :password, :local_path,
                  :destination_dir, :remote_path, :remote_pattern

    def initialize(*options)
      @files = []
      @successful      = false
      @result          = Result.new
      @download_count = 0
      @options = options

      options.extract_options!.each do |key, value|
        send("#{key}=".to_sym, value) if respond_to?("#{key}=".to_sym)
      end
    end
  end
end
