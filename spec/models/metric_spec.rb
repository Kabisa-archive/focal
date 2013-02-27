require 'spec_helper'

describe Metric do
  context "importing metrics" do
    subject(:metric) { Metric.create_for_pivotal_project(ENV['PIVOTAL_PROJECT_ID'], ENV['PIVOTAL_TOKEN']) }

    context "for today" do
      it "stores a new metric" do
        VCR.use_cassette('import_todays_metric') do
          expect(metric).to_not be_new_record

          expect(metric.iteration_id).to eql(3)
          expect(metric.captured_on).to  eql(Time.now.utc.to_date)

          expect(metric.unstarted).to eql(6)
          expect(metric.started).to   eql(2)
          expect(metric.finished).to  eql(1)
          expect(metric.delivered).to eql(2)
          expect(metric.accepted).to  eql(1)
          expect(metric.rejected).to  eql(3)
        end
      end
    end

    context "for all projects" do
      before do
        Fabricate(:burndown, pivotal_project_ids: "112,42",  pivotal_token: "ABC")
        Fabricate(:burndown, pivotal_project_ids: "88", pivotal_token: "XYZ")
      end

      it "it imports metrics" do
        Metric.should_receive(:create_for_pivotal_project).with(112, "ABC").once
        Metric.should_receive(:create_for_pivotal_project).with(42, "ABC").once
        Metric.should_receive(:create_for_pivotal_project).with(88, "XYZ").once

        Metric.import_all
      end
    end
  end

  context "merging" do
    let(:one) { Fabricate(:metric, iteration_id: 12, project_id: 42, unstarted: 12) }
    let(:two) { Fabricate(:metric, iteration_id: 11, project_id: 42, unstarted: 6) }

    subject(:result) { one.merge(two) }

    it "merges two metrics" do
      expect(result.unstarted).to eql(12 + 6)
    end
  end

  context "last_iteration" do
    it "returns nil if there is no data" do
      expect(Metric.last_iteration_for_project_id(42)).to be_nil
    end

    context "with one ore more metrics" do
      before do
        Fabricate(:metric, iteration_id: 12, project_id: 42)
        Fabricate(:metric, iteration_id: 11, project_id: 42)
      end

      it "returns the latest iteration" do
        expect(Metric.last_iteration_for_project_id(42)).to eql(12)
      end
    end
  end
end
