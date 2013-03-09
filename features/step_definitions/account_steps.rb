Given /^I have an account with "(.*?)"$/ do |email|
  @my_account = FactoryGirl.create(:admin_user, email: email)
end

When /^I sign in with "(.*?)" and "(.*?)"$/ do |email, password|
  visit '/admin/login'
  fill_in "admin_user_email", with: email
  fill_in "admin_user_password", with: password
  click_button "Login"
end

When /^I sign out$/ do
  page.driver.submit :delete, '/admin/logout', {}
end
