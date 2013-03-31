require 'spec_helper'

describe PivotalIteration do

  subject(:proxy) { PivotalIteration.new("token", 767275) }

  before do
    # Project
    stub_request(:get, "http://www.pivotaltracker.com/services/v3/projects/767275").
      with(:headers => {
        'Accept'=>'*/*; q=0.5, application/xml',
        'Accept-Encoding'=>'gzip, deflate',
        'Content-Type'=>'application/xml',
        'User-Agent'=>'Ruby',
        'X-Trackertoken'=>'token'}).
      to_return(:status => 200, :body => fixture_file("project.xml"))

    # Iteration
    stub_request(:get, "http://www.pivotaltracker.com/services/v3/projects/767275/iterations/current").
      with(:headers => {
        'Accept'=>'*/*; q=0.5, application/xml',
        'Accept-Encoding'=>'gzip, deflate',
        'Content-Type'=>'application/xml',
        'User-Agent'=>'Ruby',
        'X-Trackertoken'=>'token'}).
      to_return(:status => 200, :body => fixture_file("current_iteration.xml"))
  end

  context "utc_offset" do
    it { expect(subject.utc_offset).to eql(3600) }
  end

  context "iteration information" do
    it { expect(subject.pivotal_id).to eql(42) }
    it { expect(subject.number).to eql(4) }

    it { expect(subject.start_at).to eql(DateTime.parse("2013/03/04 00:00:00 CET")) }
    it { expect(subject.finish_at).to eql(DateTime.parse("2013/03/11 00:00:00 CET")) }
  end

  context "metrics" do
    it { expect(subject.unstarted).to eql(1) }
    it { expect(subject.started).to eql(2) }
    it { expect(subject.finished).to eql(3) }
    it { expect(subject.delivered).to eql(5) }
    it { expect(subject.accepted).to eql(8) }
    it { expect(subject.rejected).to eql(13) }
  end
end
