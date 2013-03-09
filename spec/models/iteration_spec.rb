require 'spec_helper'

describe Iteration do
  context "relations" do
    it { should belong_to(:burndown) }
    it { should have_many(:metrics).order("captured_on ASC").dependent(:destroy) }
  end
end
