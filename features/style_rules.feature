Feature: find rules defined in a stylesheet
  In order to find visual components of a website
  As a developer
  I want to find style rules in a stylesheet

  Scenario: find rules in a stylesheet
    Given I have a css file at the url http://example.com/css/stylesheets/screen.css
    When I ask the style about it's rules
    Then I should receive a list of style rules

  Scenario: find rule attributes
    Given I have a rule in the css file at the url http://example.com/css/stylesheets/screen.css
    When I ask the rule about it's attributes
    Then I should get details about the rule

