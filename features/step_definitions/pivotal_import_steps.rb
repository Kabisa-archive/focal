Given /^we have a fake Pivotal Tracker burndown$/ do
  @my_burndown = FactoryGirl.create(:burndown_with_metrics, pivotal_project_id: 42, pivotal_token: "ABC")
  @original_json = BurndownDecorator.decorate(@my_burndown).to_json

  pivotal_double =
    double :pivotal_iteration,
      number: @my_burndown.current_iteration.number,
      pivotal_id: 42,
      start_at: 1.week.ago,
      finish_at: 1.week.from_now,
      utc_offset: 3600,
      unstarted: 1,
      started: 2,
      finished: 3,
      delivered: 5,
      accepted: 8,
      rejected: 13

  Burndown.any_instance.stub(:pivotal_iteration).and_return(pivotal_double)
end

When /^the system imports metrics from Pivotal Tracker$/ do
  Burndown.import_all
  @my_burndown.reload
  @expect_json = BurndownDecorator.decorate(@my_burndown).to_json
end

When /^I can request an update for today$/ do
  burndown = double :burndown
  burndown.should_receive(:force_update).once
  Burndown.stub(:find).with(@my_burndown.id.to_s).and_return(burndown)

  visit "/admin/burndowns"
  within("#index_table_burndowns tr#burndown_#{@my_burndown.id}") do
    click_link "Force Update"
  end
end

Then /^I can see my burndown was updated$/ do
  step "I look at my burndown"

  expect(page.source).to_not have_content(@original_json)
  expect(page.source).to have_content(@expected_json)
end
