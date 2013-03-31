Feature: Manual refresh
    As a user
    I can request an update of today's data
    So the burn down reflects the current Pivotal status.

    Background:
        Given we have a fake Pivotal Tracker burndown
        And the system imports metrics from Pivotal Tracker
        And I am logged in as an administrator

    Scenario:
        Then I can request an update for today