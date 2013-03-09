require 'spec_helper'

describe Burndown do

  context "relations" do
    it { should have_many(:iterations).order("number DESC").dependent(:destroy) }
    it { should have_many(:metrics).through(:iterations) }
  end

  context "import from Pivotal Tracker" do
    context "for a single burndown" do
      subject(:burndown) { FactoryGirl.create(:burndown, pivotal_project_id: 42, pivotal_token: "ABC") }

      let(:start_datetime)  { 1.week.ago }
      let(:finish_datetime) { 1.week.from_now }

      let(:pivotal_double) {
        double :pivotal_iteration,
          number: 123,
          pivotal_id: 42,
          start_at: start_datetime,
          finish_at: finish_datetime,
          unstarted: 1,
          started: 2,
          finished: 3,
          delivered: 5,
          accepted: 8,
          rejected: 13
      }

      before do
        subject.stub(:pivotal_iteration).and_return(pivotal_double)
      end

      context "imports fresh data" do
        context "when the iteration was not yet recorded" do
          it "creates a new iteration " do
            expect {
              burndown.import
            }.to change { burndown.iterations.count }.by(1)
          end

          context "iteration data" do
            let(:iteration) { burndown.import ; Iteration.last }

            it { expect(iteration.number).to eql(123) }
            it { expect(iteration.pivotal_iteration_id).to eql(42) }
            it { expect(iteration.start_at).to eql(start_datetime) }
            it { expect(iteration.finish_at).to eql(finish_datetime) }
          end
        end

        context "when the iteration has been recorded" do
          before { burndown.import }

          it "does not create a new iteration" do
            expect {
              burndown.import
            }.to_not change { burndown.iterations.count }
          end
        end

        context "import metric data for tody" do
          it "creates a Metric" do
            expect {
              burndown.import
            }.to change { burndown.metrics.count }.by(1)
          end

          context "metric data" do
            let(:metric) { burndown.import ; Metric.last }

            it { expect(metric.iteration_id).to eql(Iteration.last.id) }
            it { expect(metric.captured_on).to eql(Time.now.utc.to_date) }

            it { expect(metric.unstarted).to eql(1) }
            it { expect(metric.started).to eql(2) }
            it { expect(metric.finished).to eql(3) }
            it { expect(metric.delivered).to eql(5) }
            it { expect(metric.accepted).to eql(8) }
            it { expect(metric.rejected).to eql(13) }
          end
        end
      end
    end

    context "for all the burndowns" do
      let(:one) { FactoryGirl.create(:burndown, pivotal_project_id: 42, pivotal_token: "ABC") }
      let(:two) { FactoryGirl.create(:burndown, pivotal_project_id: 88, pivotal_token: "XYZ") }

      before do
        Burndown.stub(:find_each).and_yield(one).and_yield(two)
      end

      it "for all burndowns" do
        one.should_receive(:import).once
        two.should_receive(:import).once

        Burndown.import_all
      end
    end
  end
end
