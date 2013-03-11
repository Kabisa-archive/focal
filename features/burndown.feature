Feature: Burndown
    As a user
    I want to see a burndown
    So I can see this sprint's progress

    Background:
        Given I have a burndown

    @javascript
    Scenario: See a Google Chart burndown
        When I look at my burndown
        Then I can see a Google Chart
        And I can see sprint progress

    Scenario: See project name
        When I look at my burndown
        Then I can see the burndown name

    Scenario: See current iteration number
        When I look at my burndown
        Then I can see the current iteration number

    Scenario: See current iteration duration
        When I look at my burndown
        Then I can see the current iteration duration

    Scenario: See link to the Pivotal Tracker project
        When I look at my burndown
        Then I see a link to the Pivotal Tracker project

    Scenario: See links to previous iterations
		When I look at my burndown
		Then I see links to previous iterations
	
    Scenario: View a previous iteration
		When I look at a previous burndown
		Then I can see the previous interation's progress
