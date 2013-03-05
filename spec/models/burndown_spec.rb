require 'spec_helper'

describe Burndown do

  context "project_ids" do
    before do
      Fabricate(:burndown, pivotal_project_ids: "112,42",  pivotal_token: "ABC")
      Fabricate(:burndown, pivotal_project_ids: "88, 112", pivotal_token: "XYZ")
    end

    subject(:data) { Burndown.pivotal_project_data }

    it "reports all project_ids" do
      expect(data.size).to eql(3)
      expect(data).to include({42 => "ABC"}, {88 => "XYZ"})
      expect(data[112]).to match(/ABC|XYZ/)
    end
  end

  context "reports data for current iteration" do
    subject(:burndown) { Fabricate(:burndown, pivotal_project_ids: "112,42") }

    context "when there is data available" do
      before do
        Fabricate(:metric, project_id: 42, captured_on: "2013-02-24")
        Fabricate(:metric, project_id: 42, captured_on: "2013-02-25")
      end

      it "returns json data" do
        expect(burndown.json_data).to have(3).elements

        expect(burndown.json_data[0]).to eql(['Day', 'Unstarted', 'Started', 'Finished', 'Delivered', 'Accepted', 'Rejected'])
        expect(burndown.json_data[1]).to eql(['Sun 24', 34, 8, 5, 3, 8, 3])
        expect(burndown.json_data[2]).to eql(['Mon 25', 34, 8, 5, 3, 8, 3])
      end

      it "returns assorted data" do
        expect(burndown.data).to have(2).elements

        metric = burndown.data.first
        expect(metric.captured_on).to eql(Date.parse("2013-02-24"))  # date
        expect(metric.unstarted).to   eql(34)
        expect(metric.started).to     eql(8)
        expect(metric.finished).to    eql(5)
        expect(metric.delivered).to   eql(3)
        expect(metric.accepted).to    eql(8)
        expect(metric.rejected).to    eql(3)
      end

      context "with multiple projects" do
        before do
          Fabricate(:metric, project_id: 112, captured_on: "2013-02-24", unstarted: 7)
        end

        it "returns merged data" do
          expect(burndown.data).to have(2).elements

          metric = burndown.data.first
          expect(metric.captured_on).to eql(Date.parse("2013-02-24"))  # date
          expect(metric.unstarted).to   eql(34 + 7)
          expect(metric.started).to     eql(8 + 8)
          expect(metric.finished).to    eql(5 + 5)
          expect(metric.delivered).to   eql(3 + 3)
          expect(metric.accepted).to    eql(8 + 8)
          expect(metric.rejected).to    eql(3 + 3)
        end
      end
    end

    context "when there is no data available" do
      it "returns an empty array" do
        expect(burndown.data).to eql([])
      end
    end
  end
end
