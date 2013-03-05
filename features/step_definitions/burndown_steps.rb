Given /^my burndown is available$/ do
  @my_burndown = Fabricate(:burndown_with_metrics)
end

When /^I download the JSON metrics data$/ do
  visit "/burndowns/#{@my_burndown.id}/metrics.json"
end

When /^I look at my burndown$/ do
  visit "/burndowns/#{@my_burndown.id}"
end

Then /^I can see sprint progress$/ do
  expect(page.source).to have_css("#burndown-chart svg")
end

Then /^I see the metrics as JSON$/ do
  expect(page.source).to be_json_eql(@my_burndown.json_data.to_json)
end