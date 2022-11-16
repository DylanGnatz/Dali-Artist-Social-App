When /^the "([^"]*)" tag is available$/ do |tag|
  Tag.create(name: tag)
end

When /^I select "([^"]*)" from tags$/ do |value|
  select value, :from => "id"
end

When /^I click to remove the "([^"]*)" tag$/ do |tag|
  click_button(tag)
end