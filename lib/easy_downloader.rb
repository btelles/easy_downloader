require 'net/sftp'
class EasyDownloader
  attr_reader :files, :result


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
    puts "Started downloading at: #{Time.now}"
    @files           = []
    @successful      = false
    @result          = ''
    @options         = options.extract_options!
    @destination_dir = @options[:local_path_with_root].gsub(/RAILS_ROOT/, Rails.root)
    download
  end

  def successful?
    @successful
  end

  private 

  def download
    begin
      case @options[:type].to_sym
      when :sftp
        sftp_download
      end

    rescue 
      @result += <<-ERROR_MESSAGE
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

  def sftp_download
    downloaded = 0
    Net::SFTP.start(@options[:host],
                    @options[:user], 
                    password_option) do |sftp|


      files = sftp.dir.glob(@options[:remote_path], @options[:remote_pattern])
      total = files.size
      @result += "We found #{total} file(s) to download with the following names: \n"
      files.each do |file|
        @result += "#{file.name}\n"
      end

      files.map(&:name).each do |path|
        @result += "Starting to download #{path}\n"
        downloaded += 1 if sftp.download!("#{@options[:remote_path]}#{path}", "#{@destination_dir}#{path}")
        @result += "Finished downloading #{path}\n"
        @files << "#{@destination_dir}#{path}"
      end
    end
    @successful = true
    @result +="Downloaded #{downloaded} file(s)"
    puts "Finished downloading at: #{Time.now}"
  end

  def password_option
    @options[:password] ?
      {:password => @options[:password]} :
      Hash.new
  end
end
