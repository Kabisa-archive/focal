Given(/^a campfire enabled burndown exists$/) do
  @my_burndown = FactoryGirl.create(:burndown_with_metrics,
      campfire_subdomain: 'domain',
      campfire_token: 'token',
      campfire_room_id: '4242')

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

  WebMock.stub_request(:get, "https://token:X@domain.campfirenow.com/rooms.json").to_return(
    :status => 200,
    :body => "{\"rooms\":[{\"name\":\"Developers\",\"topic\":\"\",\"id\":4242,\"membership_limit\":25,\"locked\":false}]}",
    :headers => {})
  WebMock.stub_request(:post, "https://token:X@domain.campfirenow.com/room/4242/speak.json").to_return(
    :status => 200, :body => "", :headers => {})
end

When(/^I update the campfire credentials$/) do
  visit "/admin/burndowns/#{@burndown.id}/edit"

  within('#edit_burndown') do
    fill_in "Campfire Subdomain", with: "campfire-domain"
    fill_in "Campfire API Token", with: "campfire-token"
    fill_in "Campfire Room ID", with: "campfire-room_id"

    click_button "Update Burndown"
  end
end

Then(/^I should see campfire notifications enabled$/) do
  visit "/admin/burndowns"

  within("#index_table_burndowns tr#burndown_#{@burndown.id} td.campfire_enabled") do
    expect(page).to have_content("Yes")
  end
end

When(/^the system imports the burndown$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^a notification is posted to Campfire$/) do
  WebMock.should have_requested(:post, "https://token:X@domain.campfirenow.com/room/4242/speak.json")
end