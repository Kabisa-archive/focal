require 'spec_helper'

describe IterationDecorator do
  let(:start_at)  { 5.days.ago }
  let(:finish_at) { 1.days.from_now }

  subject(:iteration) {
    FactoryGirl.create(
      :iteration_with_metrics,
      metrics_count: 3,
      start_at:      start_at,
      finish_at:     finish_at
    ).decorate
  }

  context "#start_on" do
    it "returns the start date" do
      expect(iteration.start_on).to eql(start_at.strftime("%F"))
    end
  end

  context "#finish_on" do
    it "returns the finish date" do
      expect(iteration.finish_on).to eql(finish_at.strftime("%F"))
    end
  end

  context "#to_json" do
    it "returns the correct JSON" do
      base_date = iteration.start_at
      expected = [
        ['Day', 'Unstarted', 'Started', 'Finished', 'Delivered', 'Accepted', 'Rejected'],
        [(base_date + 0.days).strftime("%a %e"), 5, 8, 13, 21, 34, 55],
        [(base_date + 1.days).strftime("%a %e"), 5, 8, 13, 21, 34, 55],
        [(base_date + 2.days).strftime("%a %e"), 5, 8, 13, 21, 34, 55],
        [(base_date + 3.days).strftime("%a %e"), 0, 0,  0,  0,  0,  0],
        [(base_date + 4.days).strftime("%a %e"), 0, 0,  0,  0,  0,  0],
        [(base_date + 5.days).strftime("%a %e"), 0, 0,  0,  0,  0,  0],
        [(base_date + 6.days).strftime("%a %e"), 0, 0,  0,  0,  0,  0],
      ].to_json

      expect(iteration.to_json).to be_json_eql(expected)
    end
  end
end
