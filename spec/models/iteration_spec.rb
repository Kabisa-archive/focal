require 'spec_helper'

describe Iteration do
  context "relations" do
    it { should belong_to(:burndown) }
    it { should have_many(:metrics).order("captured_on ASC").dependent(:destroy) }
  end

  context "dates" do
    subject { FactoryGirl.create :iteration }

    it { expect(subject.start_on).to  eql(subject.start_at.to_date) }
    it { expect(subject.finish_on).to eql(subject.finish_at.to_date) }
  end
end
