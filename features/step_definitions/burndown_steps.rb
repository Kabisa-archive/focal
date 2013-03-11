Given /^I have a burndown$/ do
  @my_burndown = FactoryGirl.create(:burndown_with_metrics, iteration_count: 3)
end

When /^I look at my burndown$/ do
  visit "/burndowns/#{@my_burndown.id}"
end

When /^I look at a previous burndown$/ do
  @previous_iteration = @my_burndown.previous_iterations.first
  visit "/burndowns/#{@my_burndown.id}/iterations/#{@previous_iteration.number}"
end

Then /^I can see a Google Chart$/ do
  expect(page.source).to have_css("#burndown-chart svg")
end

Then /^I can see sprint progress$/ do
  expected = IterationDecorator.decorate(@my_burndown.current_iteration).to_json
  expect(page.source).to have_content(expected)
end

Then /^I can see the previous interation's progress$/ do
  expected = IterationDecorator.decorate(@previous_iteration).to_json
  expect(page.source).to have_content(expected)
end

Then /^I can see the burndown name$/ do
  within("#burndown_#{@my_burndown.id}") do
    expect(page).to have_content(@my_burndown.name)
  end
end

Then /^I can see the current iteration number$/ do
  within("#burndown_#{@my_burndown.id}") do
    expect(page).to have_content("Iteration #{@my_burndown.current_iteration.number}")
  end
end

Then /^I can see the current iteration duration$/ do
  within("#burndown_#{@my_burndown.id}") do
    start_on  = @my_burndown.current_iteration.start_at.strftime("%F")
    finish_on = @my_burndown.current_iteration.finish_at.strftime("%F")

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

Then /^I see links to previous iterations$/ do
  @my_burndown.previous_iterations.each do |iteration|
    within("#previous_iterations") do
      url = "/burndowns/#{@my_burndown.id}/iterations/#{iteration.number}"
      expect(page).to have_link("Iteration #{iteration.number}", href: url)
    end
  end
end
