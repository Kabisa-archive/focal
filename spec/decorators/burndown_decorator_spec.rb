require 'spec_helper'

describe BurndownDecorator do

  context "#pivotal_tracker_url" do
    subject(:burndown) {
      BurndownDecorator.decorate(FactoryGirl.create(:burndown, pivotal_project_id: 123123))
    }

    it "returns URL to pivotal tracker" do
      expected = "https://pivotaltracker.com/projects/123123"
      expect(burndown.pivotal_tracker_url).to eql(expected)
    end
  end

  context "#start_on" do
    subject(:burndown) {
      BurndownDecorator.decorate(FactoryGirl.create(:burndown_with_metrics))
    }

    it "returns the start date" do
      expect(burndown.start_on).to eql(burndown.iterations.last.start_at.strftime("%F"))
    end
  end

  context "#finish_on" do
    subject(:burndown) {
      BurndownDecorator.decorate(FactoryGirl.create(:burndown_with_metrics))
    }

    it "returns the finish date" do
      expect(burndown.finish_on).to eql(burndown.iterations.last.finish_at.strftime("%F"))
    end
  end

  context "#iteration_number" do
    subject(:burndown) {
      BurndownDecorator.decorate(FactoryGirl.create(:burndown_with_metrics))
    }

    it "returns the current iteation number" do
      expect(burndown.iteration_number).to eql(burndown.iterations.last.number)
    end
  end

  context "#to_json" do
    let!(:burndown)          { FactoryGirl.create(:burndown_with_metrics) }

    subject { burndown.reload.decorate }

    it "returns the correct JSON" do
      expected = [
        ['Day', 'Unstarted', 'Started', 'Finished', 'Delivered', 'Accepted', 'Rejected'],
        [7.days.ago.strftime("%a %e"), 5, 8, 13, 21, 34, 55],
        [6.days.ago.strftime("%a %e"), 5, 8, 13, 21, 34, 55],
        [5.days.ago.strftime("%a %e"), 5, 8, 13, 21, 34, 55]
      ].to_json

      expect(subject.to_json).to be_json_eql(expected)
    end
  end
end
