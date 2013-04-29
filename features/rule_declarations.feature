Feature: find declarations defined in a style rules
  In order to find visual components of a website
  As a developer
  I want to find the css rule declarations in a style rule

  Scenario: find declarations in style rules
    Given I have a rule in the css file at the url http://example.com/css/stylesheets/screen.css
    When I ask a rule about it's styles
    Then I should get style declarations
