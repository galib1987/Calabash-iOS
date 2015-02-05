Given /^I am on the Welcome Screen$/ do
  element_exists("view")
  sleep(STEP_PAUSE)
end


Given /^I am on the Welcome Screen$/ do
  element_exists("view")
  sleep(STEP_PAUSE)
end

Given /^I am on the Login Screen$/ do
  element_exists("view")
  sleep(STEP_PAUSE)
end




Then(/^I enter "([^"]*)" into "([^"]*)" field$/) do |arg1, arg2|
  touch("textField value:’#{arg2}'")

  sleep 30
  wait_for_keyboard()
  keyboard_enter_text arg1
  sleep(STEP_PAUSE)
end



Then(/^I enter "([^"]*)" into the  "([^"]*)" field name$/) do |arg1, arg2|

  query("UITextFieldLabel text:'#{arg2}'", {:setText => arg1})

  sleep(STEP_PAUSE)

end




Then(/^I enter "([^"]*)" into the  "([^"]*)" field fname$/) do |arg1, arg2|
  query("UITextFieldLabel text:'#{arg2}'", {:setText => arg1})
  sleep(STEP_PAUSE)
end

Then(/^I enter "([^"]*)" into "([^"]*)" input field$/) do |arg1, arg2|
  query("UITextFieldLabel text:'#{arg2}'", {:setText => arg1})

  sleep(STEP_PAUSE)
end

Then(/^I should return to Login Screen$/) do
  element_exists("view")
  sleep(STEP_PAUSE)
  sleep 2
end



When(/^I press Menu_Button$/) do
  #sleep 2
  touch("UIImageView id:'menu-hamburger-off'")
end

Then(/^I touch VIEW FLIGHT DETAILS button$/) do
  touch("UIButton label:'VIEW FLIGHT DETAILS'")
end


Then(/^I should see Paris is always a good idea text$/) do
  element_exists( "view text:'Paris is always a good idea.'")
end