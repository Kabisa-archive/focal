Feature: Burndown
  As a user
  I want to see a burndown
  So I can see this sprint's progress

  Background:
    Given I have a burndown

  @javascript
  Scenario:
    When I look at my burndown
    Then I can see a Google Chart
    And I can see sprint progress
