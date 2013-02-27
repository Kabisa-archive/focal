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

      it "returns assorted data" do
        expect(burndown.data).to have(2).elements

        expect(burndown.data.keys).to include("2013-02-24", "2013-02-25")
      end

      context "with multiple projects" do
        before do
          Fabricate(:metric, project_id: 112, captured_on: "2013-02-24", unstarted: 7)
        end

        it "returns merged data" do
          expect(burndown.data).to have(2).elements
          expect(burndown.data["2013-02-24"].unstarted).to eql(34 + 7)
        end
      end
    end

    context "when there is no data available" do
      it "returns an empty array" do
        expect(burndown.data).to eql({})
      end
    end
  end
end
