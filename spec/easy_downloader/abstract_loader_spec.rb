require 'spec_helper'
require 'easy_downloader/abstract_loader'

describe EasyDownloader::AbstractLoader do
  describe "sets options" do
    it "creates a new options object" do
      abs = EasyDownloader::AbstractLoader.new(:local_path => 'hi')
      abs.instance_variable_get(:@options).should be_instance_of(EasyDownloader::Options)
    end
  end

  describe "#execute" do
    subject { EasyDownloader::AbstractLoader.new({:local_path => 'hi'})}
    before do
      subject.stub(:execute_load => true)
    end

    it "sets the start time" do
      subject.execute
      subject.result.started_at.should be > (3.seconds.ago)
    end

    it "executes the load" do
      subject.should_receive :execute_load
      subject.execute
    end

    it "sets the finished time" do
      subject.execute
      subject.result.finished_at.should be > (3.seconds.ago)
    end

    it "sets the number of files loaded to 0 when starting out" do
      subject.execute
      subject.result.loaded.should == 0
    end
  end
end
