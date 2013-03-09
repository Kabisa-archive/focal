require 'spec_helper'

describe Metric do
  it { should belong_to(:iteration) }
end
