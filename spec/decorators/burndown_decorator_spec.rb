require 'spec_helper'

describe BurndownDecorator do
  subject(:burndown) {
    BurndownDecorator.decorate(
      FactoryGirl.create(:burndown_with_metrics,
        pivotal_project_id: 123123,
        iteration_count: 3,
        campfire_subdomain: 'domain',
        campfire_token: 'abcdef',
        campfire_room_id: '42'
      )
    )
  }

  context "#pivotal_tracker_url" do
    it "returns URL to pivotal tracker" do
      expected = "https://pivotaltracker.com/projects/123123"
      expect(burndown.pivotal_tracker_url).to eql(expected)
    end
  end

  context "#campfire_enabled" do
    it "returns 'Yes' when enabled" do
      expect(burndown.campfire_enabled).to eql('Yes')
    end

    it "returns 'No' when not enabled" do
      burndown.update_attributes(
        campfire_subdomain: nil,
        campfire_token: nil,
        campfire_room_id: nil)

      expect(burndown.campfire_enabled).to eql('No')
    end
  end
end
