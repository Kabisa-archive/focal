Given /^I have a burndown$/ do
  @my_burndown = FactoryGirl.create(:burndown_with_metrics)
end

When /^I look at my burndown$/ do
  visit "/burndowns/#{@my_burndown.id}"
end

Then /^I can see a Google Chart$/ do
  expect(page.source).to have_css("#burndown-chart svg")
end

Then /^I can see sprint progress$/ do
  expect(page.source).to have_content(BurndownDecorator.decorate(@my_burndown).to_json)
end