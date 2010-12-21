module EasyDownloader
  class Result
    attr_accessor :errors, :files_downloaded

    def initialize
      @header, @started, @finished, @errors= ''
      @files_downloaded = []
      @progress = ["Progress:"]
    end

    def to_s 
      [@header,
       found_list,
       started_string,
       progress,
       @errors,
       finished_string,
       @footer].join("\n")
    end

    def found(total_found, file_names)
      @found = total_found
      @header= "We found #{total_found} file(s) to download with the following names: \n"
      @found_list = file_names
    end

    def started
      @started= Time.now
    end

    def finished
      @finished= Time.now
    end

    def downloaded(total)
      @downloaded = total
      @footer= "Downloaded #{total} file(s)"
    end

    def starting_path(path)
      @progress << "Starting to download #{path}"
    end

    def finished_path(path)
      @progress << "Finished downloading #{path}"
    end

    private 

    def progress
      @progress.join("\n")
    end

    def found_list
      full_list = ''
      @found_list.each_with_index do |file_name, index|
        full_list += "##{(index+1).to_s}. #{file_name} "
      end
      full_list
    end

    def started_string
      "Started downloading at #{@started}"
    end

    def finished_string
      "Finished downloading at #{@finished}"
    end

  end
end
