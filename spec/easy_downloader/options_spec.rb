require 'spec_helper'

require 'easy_downloader/options'

describe EasyDownloader::Options do
  context 'Accessors' do
   [:files, :successful, :result, :download_count,
    :host, :user, :password, :local_path,
    :destination_dir, :remote_path, :remote_pattern].each do |accessor|
     specify {subject.should respond_to(accessor)}
    end
  end

  describe "exposes options" do
    [:host, :user, :password, :remote_path, :remote_pattern, :local_path].each_with_index do |exposable_option, index|
      it "exposes #{exposable_option}" do
        option = EasyDownloader::Options.new(exposable_option => "hi there #{index}")
        option.send(exposable_option).should == "hi there #{index}"
      end
    end
    it "exposes type as a symbol" do
      option = EasyDownloader::Options.new(:type => "hithere")
      option.type.should == :hithere
    end
  end
end
