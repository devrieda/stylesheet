Before do 
  Stylesheet.request = FakeRequest.new
end

Given(/^I have a document at the url (.*)$/) do |url|
  @document = Document.new(url)
end

When(/^I ask for style sheets$/) do
  @sheets = @document.style_sheets
end

Then(/^I should receive a list of stylesheets$/) do
  expect(@sheets).to be_kind_of(StyleSheetList)
end

Given(/^I have a css file found in the document (.*)$/) do |url|
  @stylesheet = Document.new(url).style_sheets[0]
end

When(/^I ask the stylesheet about it's attributes$/) do
  @type     = @stylesheet.type
  @href     = @stylesheet.href
  @disabled = @stylesheet.disabled?
  @rules    = @stylesheet.css_rules
  
  @media = @stylesheet.media
end

Then(/^I should get details about the stylesheet$/) do
  expect(@type).to eq "text/css"
  expect(@href).to eq "http://example.com/css/stylesheets/screen.css"
  expect(@disabled).to be_false
  expect(@rules).to be_kind_of(CssRuleList)
end

Then(/^the media the stylesheet was intended for$/) do
  expect(@media).to be_kind_of(MediaList)
end