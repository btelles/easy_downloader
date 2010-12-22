require 'spec_helper'

require 'easy_downloader/options'

describe EasyDownloader::Options do
  context 'Accessors' do
   [:files, :successful, :result, :load_count,
    :host, :user, :password,
    :local_path, :remote_path,
    :local_pattern, :remote_pattern,
    :local_file, :remote_file].each do |accessor|
     specify {subject.should respond_to(accessor)}
    end
  end

  describe "exposes options" do
    [:host, :user, :password, :remote_pattern].each_with_index do |exposable_option, index|
      it "exposes #{exposable_option}" do
        option = EasyDownloader::Options.new(exposable_option => "hi there #{index}")
        option.send(exposable_option).should == "hi there #{index}"
      end
    end

    it "exposes type as a symbol" do
      option = EasyDownloader::Options.new(:type => "hithere")
      option.type.should == :hithere
    end

    context "exposes local_path with a '/' in the end" do
      it "even if there isn't one" do
        option = EasyDownloader::Options.new(:local_path => "hithere")
        option.send(:local_path).should == "hithere/"
      end

      it "if there's already one" do
        option = EasyDownloader::Options.new(:local_path => "hithere/")
        option.send(:local_path).should == "hithere/"
      end
    end

    context "exposes remote_path with a '/' in the end" do
      it "even if there isn't one" do
        option = EasyDownloader::Options.new(:remote_path => "hithere")
        option.send(:remote_path).should == "hithere/"
      end

      it "if there's already one" do
        option = EasyDownloader::Options.new(:remote_path => "hithere/")
        option.send(:remote_path).should == "hithere/"
      end
    end
  end
end
