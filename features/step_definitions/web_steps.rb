def wait_until
  require "timeout"
  #Timeout.timeout(Capybara.default_wait_time) do
  Timeout.timeout(10) do
    sleep(0.1) until value = yield
    value
  end
end
def search_text text
  wait_until do
    if text.is_a? Regexp
      expect(page).to have_content text
    else
      expect(page).to have_content text
    end
  end
end
Then(/^I should( not)? see "([^"]*)"$/) do |not_see, string|
  unless not_see
    expect(page.body).to have_text string
  else
    expect(page.body).to_not have_text string
  end
end

And(/^I press "([^"]*)"$/) do |name|
  click_on name
end

Then(/^I should see "([^"]*)" between "([^"]*)" and "([^"]*)"$/) do |toSearch, first, last|
  regex = /#{first}.+#{toSearch}.+#{last}/
  search_text regex
end

Then(/^I wait for (\d+) seconds$/) do |seconds|
  sleep seconds.to_i.seconds
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in field, with: value
end

When(/^I click the "([^"]*)" link$/) do |link|
  click_link link
end

When(/^I click(?: the)? "([^"]*)" button$/) do |button|
  click_button button
end

When(/^I fill in the fields:$/) do |table|
  # table is a table.hashes.keys # => [:First name, :John]
  table.raw.each do |field, value|
    fill_in field, :with => value
  end
end

And(/^show me the page$/) do
  save_and_open_page
end

When(/^I confirm the popup dialog$/) do
  #page.accept_confirm # clicks the 'OK' button
  box = page.driver.browser.switch_to.alert
  box.accept
  
  # If wish to confirm the text of the dialog box, this will work:
  #   box = page.driver.browser.switch_to.alert
  #   expect(box.text).to eq '<expected text here .....'
  # The box can be accepted:
  #   box.accept
  # Or dismissed:
  #   box.dismiss
end

When(/^I select "([^"]*)" in select list "([^"]*)"$/) do |item, list|
  find(:select, list).find(:option, item).select_option
end

And(/^I check "([^"]*)"$/) do |item|
  check(item)
end

And(/^the selection "([^"]*)" should be disabled$/) do |item|
  expect(has_field?(item, disabled: true)).to be true
end
