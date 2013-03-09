require 'spec_helper'

describe BurndownDecorator do

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
