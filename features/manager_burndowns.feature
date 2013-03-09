Feature: Manage burndown
    As an administrator
    I want to manage burndowns
    So I have the proper burndowns available to me

    Background:
        Given I am logged in as an administrator

    Scenario: Create a new burndown
        When go the new burndown page
        And I fill out the burndown form
        Then I should have a new burndown

    Scenario: Update the pivotal token of a burndown
        Given a burndown exists
        When I update the pivotal token of the burndown
        Then I should see the pivotal token updated

    Scenario: Update the name of a burndown
        Given a burndown exists
        When I update the name of the burndown
        Then I should see name updated

    Scenario: Update the pivotal project ID
        Given a burndown exists
        Then I am not able to update the pivotal project ID

    Scenario: List of all burndowns
        Given 2 burndowns exists
        Then I should see those burndowns in the overview

    Scenario: Delete a burndown
        Given a burndown exists
        When I delete the burndown
        Then the burndown is no longer available

