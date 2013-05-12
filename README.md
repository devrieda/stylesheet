## Stylesheet

The Stylesheet gem provides a parser for CSS Stylesheets based on the DOM API

## Examples

Get styles from a document: 

```ruby
document = Stylesheet::Document.new("http://sportspyder.com")
=> #<Document location:http://sportspyder.com/>

document.style_sheets
=> [#<Stylesheet::CssStyleSheet:0x007fa905c58c20>, 
    #<Stylesheet::CssStyleSheet:0x007fa905c5f430>, 
    #<Stylesheet::CssStyleSheet:0x007fa905c5e968>]
```

Get attributes of a stylesheet: 

```ruby
sheet = document.style_sheets[0]
=> #<Stylesheet::CssStyleSheet:0x007fa905c58c20>

sheet.href
=> "http://sportspyder.com/assets/application-26ff2c8d54ab9cd8e74af60fc650390e.css"

sheet.type
=> "text/css"
```

Get stylesheet media definitions: 

```ruby
sheet.media.map {|medium| medium }
=> ["screen"]
```

Get rules defined in a stylesheet: 

```ruby
sheet = Stylesheet::CssStyleSheet.new("http://sportspyder.com/stylesheets/screen.css")
=> #<Stylesheet::CssStyleSheet:0x007fa905c58c20>

rule = sheet.css_rules[0]
=> #<Stylesheet::CssStyleRule>

rule.css_text
=> "iframe.editor{width:580px;height:150px;border:1px solid #ccc;background-color:#fff}"

rule.selector_text
=> "iframe.editor"
```

Get declarations defined in a style rules: 

```ruby
rule.style[0]
=> "width:580px"

rule.style.border
=> "1px solid #ccc"
```

## Installation

To install Stylesheet, add the gem to your Gemfile: 

```ruby
gem "stylesheet", "~> 0.1.0"
```

## LICENSE

Copyright (c) 2013 Derek DeVries

Released under the [MIT License](http://www.opensource.org/licenses/MIT)
