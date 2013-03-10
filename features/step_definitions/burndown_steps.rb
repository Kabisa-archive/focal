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

Then /^I can see the burndown name$/ do
  within("#burndown_#{@my_burndown.id}") do
    expect(page).to have_content(@my_burndown.name)
  end
end

Then /^I can see the current iteration number$/ do
  within("#burndown_#{@my_burndown.id}") do
    expect(page).to have_content("Iteration #{@my_burndown.iterations.last.number}")
  end
end

Then /^I can see the current iteration duration$/ do
  within("#burndown_#{@my_burndown.id}") do
    start_on  = @my_burndown.iterations.last.start_at.strftime("%F")
    finish_on = @my_burndown.iterations.last.finish_at.strftime("%F")

    expect(page).to have_content(start_on)
    expect(page).to have_content(finish_on)
  end
end

Then /^I see a link to the Pivotal Tracker project$/ do
  within("#burndown_#{@my_burndown.id}") do
    pt_url = "https://pivotaltracker.com/projects/#{@my_burndown.pivotal_project_id}"
    expect(page).to have_link("pivotal tracker", href: pt_url)
  end
end

