Before do 
  Stylesheet.request = FakeRequest.new
end

When(/^I ask a rule about it's styles$/) do
  @declarations = @rule.style
end

Then(/^I should get style declarations$/) do
  expect(@declarations.css_text).to eq "color: #444; background-color: #535353;"
  expect(@declarations[0]).to eq    "color: #444"
  expect(@declarations.color).to eq "#444"
end