Feature: Burndown
  As a user
  I want to see a burndown
  So I can see this sprint's progress

  Background:
    Given my burndown is available

  Scenario:
    When I download the JSON metrics data
    Then I see the metrics as JSON

  @javascript
  Scenario:
    When I look at my burndown
    Then I can see sprint progress
