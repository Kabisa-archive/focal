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