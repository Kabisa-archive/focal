Feature: Campfire Integration
    As a user
    I want to see a notification in Campfire
    So I can easily see the updated burndown

    Background:
        Given I am logged in as an administrator

    Scenario: Post Campfire message after import

    Scenario: Add Campfire credentials in admin
        Given a burndown exists
        When I update the campfire credentials
        Then I should see campfire notifications enabled
