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

  context "#pivotal_tracker_url" do
    it "returns URL to pivotal tracker" do
      expected = "https://pivotaltracker.com/projects/123123"
      expect(burndown.pivotal_tracker_url).to eql(expected)
    end
  end
end
