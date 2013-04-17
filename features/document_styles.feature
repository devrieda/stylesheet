Feature: find stylesheets from documents
  In order to find visual components of a website
  As a developer
  I want to find the stylesheets in a document

  Scenario: find document styles
    Given I have a document at the url http://example.com/css/absolute_path.html
    When I ask for style sheets
    Then I should receive a list of stylesheets
  
  Scenario: find stylesheet attributes
    Given I have a css file found in the document http://example.com/css/absolute_path.html
    When I ask the stylesheet about it's attributes
    Then I should get details about the stylesheet
    And the media the stylesheet was intended for
