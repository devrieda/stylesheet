Before do 
  Stylesheet.request = FakeRequest.new
end

Given(/^I have a css file at the url (.*)$/) do |url|
  @stylesheet = CssStyleSheet.new(url)
end

When(/^I ask the style about it's rules$/) do
  @rules = @stylesheet.css_rules
end

Then(/^I should receive a list of style rules$/) do
  expect(@rules).to be_kind_of CssRuleList
end

Given(/^I have a rule in the css file at the url (.*)$/) do |url|
  @rule = CssStyleSheet.new(url).css_rules[0]
end

When(/^I ask the rule about it's attributes$/) do
  @css_text = @rule.css_text
  @selector = @rule.selector_text
  @type     = @rule.type
end

Then(/^I should get details about the rule$/) do
  expect(@css_text).to eq "body { color: #444;background-color: #535353;}"
  expect(@selector).to eq "body"
  expect(@type).to eq CssRule::STYLE_RULE
end