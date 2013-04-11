Feature: find stylesheets from documents
  In order to programmatically find visual components of a website
  As a developer
  I want to find the stylesheets in a document
  
  Scenario: Find document styles
    Given I have the url http://example.com/css/absolute.html
    When I ask for style sheets
    Then I should receive a list of stylesheets
  
  