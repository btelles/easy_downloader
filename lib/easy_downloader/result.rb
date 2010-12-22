module EasyDownloader
  class Result
    attr_accessor :errors, :files_loaded

    def initialize
      @header, @started, @finished, @errors= ''
      @files_loaded = []
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
      @header= "We found #{total_found} file(s) to load with the following names: \n"
      @found_list = file_names
    end

    def started
      @started= Time.now
    end

    def started_at; @started; end

    def finished
      @finished= Time.now
    end

    def finished_at; @finished; end



    def loaded(total = false)
      if total
        @loaded = total
        @footer= "Loaded #{total} file(s)"
      else
        @loaded
      end
    end

    def starting_path(path)
      @progress << "Starting to load #{path}"
    end

    def finished_path(path)
      @progress << "Finished loading #{path}"
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
      "Started loading at #{@started}"
    end

    def finished_string
      "Finished loading at #{@finished}"
    end

  end
end
