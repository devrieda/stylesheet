## Stylesheet

The Stylesheet gem provides a parser for CSS Stylesheets based on the DOM API

**This Gem is in an extremely experimental state right now**


## Examples

Get styles from a document: 

```ruby
document = Stylesheet::Document.new("http://sportspyder.com")
document.style_sheets
```

Get attributes of a stylesheet: 

```ruby
sheet = document.style_sheets[0]
puts sheet.href
puts sheet.type
```

Get stylesheet media definitions: 

```ruby
sheet = document.style_sheets[0]
sheet.media.each do |media| 
  puts media
end
```

Get rules defined in a stylesheet: 

```ruby
sheet = Stylesheet::CssStyleSheet.new("http://sportspyder.com/stylesheets/screen.css")
sheet.css_rules.each do |rule|
  puts rule.css_text
  puts rule.selector_text
end
```

Get declarations defined in a style rules: 

```ruby
sheet = document.style_sheets[0]
rule  = sheet.css_rules[0]
puts rule.style[0]
puts rule.style.border
```

## Installation

```
gem install stylesheet
```
```
gem "stylesheet"
```

## LICENSE

Copyright (c) 2013 Derek DeVries

Released under the [MIT License](http://www.opensource.org/licenses/MIT)
