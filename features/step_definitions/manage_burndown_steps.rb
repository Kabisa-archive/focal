Given /^(\d+) burndowns exists$/ do |count|
  @burndowns = FactoryGirl.create_list(:burndown, count.to_i)
end

Given /^a burndown exists$/ do
  @burndown = FactoryGirl.create(:burndown)
end

When /^go the new burndown page$/ do
  visit "/admin/burndowns/new"
end

When /^I fill out the burndown form$/ do
  within('#new_burndown') do
    fill_in "Name", with: "My Burndown"
    fill_in "Pivotal Tracker API Token", with: "pivotal-token"
    fill_in "Pivotal Tracker Project ID", with: "123123"

    click_button "Create Burndown"
  end
end

When /^I update the pivotal token of the burndown$/ do
  visit "/admin/burndowns/#{@burndown.id}/edit"

  within('#edit_burndown') do
    fill_in "Pivotal Tracker API Token", with: "something-different"

    click_button "Update Burndown"
  end
end

When /^I update the name of the burndown$/ do
  visit "/admin/burndowns/#{@burndown.id}/edit"

  within('#edit_burndown') do
    fill_in "Name", with: "Other Awesome Burndown"

    click_button "Update Burndown"
  end
end

When /^I delete the burndown$/ do
  visit "/admin/burndowns"
  within("#burndowns tr#burndown_#{@burndown.id}") do
    click_link "Delete"
  end

end

Then /^I should see the pivotal token updated$/ do
  visit "/admin/burndowns/#{@burndown.id}"

  expect(page).to have_content(@burndown.name)
  expect(page).to have_content("something-different")
  expect(page).to have_content(@burndown.pivotal_project_id)
end

Then /^I should see name updated$/ do
  visit "/admin/burndowns/#{@burndown.id}"

  expect(page).to have_content("Other Awesome Burndown")
  expect(page).to have_content(@burndown.pivotal_token)
  expect(page).to have_content(@burndown.pivotal_project_id)
end

Then /^I should have a new burndown$/ do
  burndown = Burndown.last
  visit "/admin/burndowns/#{burndown.id}"

  expect(page).to have_content("My Burndown")
  expect(page).to have_content("pivotal-token")
  expect(page).to have_content("123123")
end

Then /^I am not able to update the pivotal project ID$/ do
  visit "/admin/burndowns/#{@burndown.id}/edit"

  within("#edit_burndown") do
    expect(page).to_not have_selector("input#burndown_pivotal_project_id")
  end
end

Then /^I should see those burndowns in the overview$/ do
  visit "/admin/burndowns"

  @burndowns.each do |burndown|
    within("table#burndowns") do
      expect(page).to have_selector("tr#burndown_#{burndown.id}")
      within("tr#burndown_#{burndown.id}") do
        expect(page).to_not have_selector("td.id")
        expect(page).to_not have_selector("td.pivotal_token")
        expect(page).to_not have_selector("td.pivotal_project_id")

        expect(page).to have_selector("td.name")
        within("td.name") do
          expect(page).to have_content(burndown.name)
        end
      end
    end
  end
end

Then /^the burndown is no longer available$/ do
  visit "/admin/burndowns"

  expect(page).to_not have_selector("tr#burndown_#{@burndown.id}")
end
