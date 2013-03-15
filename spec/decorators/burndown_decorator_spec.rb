require 'spec_helper'

describe BurndownDecorator do
  subject(:burndown) {
    BurndownDecorator.decorate(
      FactoryGirl.create(:burndown_with_metrics,
        pivotal_project_id: 123123,
        iteration_count: 3
      )
    )
  }

  context "#session_identifier" do
    it "returns a unique session id" do
      expect(burndown.session_identifier).to eql("session_burndown_#{burndown.id}")
    end
  end

  context "#pivotal_tracker_url" do
    it "returns URL to pivotal tracker" do
      expected = "https://pivotaltracker.com/projects/123123"
      expect(burndown.pivotal_tracker_url).to eql(expected)
    end
  end
end
