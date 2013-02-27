require 'spec_helper'

describe PivotalProject do

  subject(:project) { PivotalProject.new(ENV['PIVOTAL_PROJECT_ID'], ENV['PIVOTAL_TOKEN']) }

  it "retrieves current project status" do
    VCR.use_cassette('import_todays_metric') do
      expect(project.iteration_id).to eql(3)
      expect(project.captured_on).to eql(Time.now.utc.to_date)

      expect(project.unstarted).to eql(6)
      expect(project.started).to   eql(2)
      expect(project.finished).to  eql(1)
      expect(project.delivered).to eql(2)
      expect(project.accepted).to  eql(1)
      expect(project.rejected).to  eql(3)
    end
  end

end
