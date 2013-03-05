Then /^I should see "(.*?)"$/ do |text|
  expect(page).to have_content(text)
end

Then /^show me the page$/ do
  save_and_open_page
end
