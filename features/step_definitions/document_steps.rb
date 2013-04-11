Before do 
  Stylesheet.request = FakeRequest.new
end

Given(/^I have the url (.*)$/) do |url|
  @document = Document.new(url)
end

When(/^I ask for style sheets$/) do
  @sheets = @document.style_sheets
end

Then(/^I should receive a list of stylesheets$/) do
  expect(@sheets).to be_kind_of(StyleSheetList)
end