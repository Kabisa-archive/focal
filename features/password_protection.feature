Feature: Password protection
    As a user
    I want my burndown to be password protected
    So not every John can watch my sprint progress

    Background:
        Given I am logged in as an administrator

    Scenario: Set password for burndown
        Given I have a burndown

        When I set a password for my burndown
        And I look at my burndown

        Then I should see "This burndown is protected"

    Scenario: View with a password
        Given I have a password protected burndown

        When I look at my burndown
        And I enter my burndown's password

        Then I can see my burndown

    Scenario: Remove password for burndown
        Given I have a password protected burndown
        And when I look at my burndown
        And I should see "Please enter password"

        When I set no password for my burndown
        And I look at my burndown

        Then I can see my burndown

