Feature: Game

  Background:
    Given the app is running

  Scenario: As a User I want to see initial text
    Then I see {'Time: 00:00'} text
    And I see {'Steps: 0'} text
    And I see {'1'} text
    And I see {Icons.repeat} icon

  Scenario: As a User I start game
    When I tap {'1'} text
    Then I don't see {'Steps: 0'} text
    And I see {'Steps: 1'} text

  Scenario: As a User I want to restart game
    When I tap {'1'} text
    And I tap {Icons.repeat} icon
    Then I don't see {'Steps: 1'}
    And I see {'Steps: 0'} text

