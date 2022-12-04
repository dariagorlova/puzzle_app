Feature: Game

  Background:
    Given the app is running

  Scenario: As a User I want to see initial text
    Then I see {'1'} text
    And I see {'Steps: 0'} text
    And I see {'Time: 00:00'} text
    And I see {Icons.replay} icon

  Scenario: As a User I start game and chose wrong number
    When I tap {'1'} text
    And I wait {2} second
    Then I see {'Steps: 0'} text
    And I don't see {'Time: 00:00'} text

  Scenario: As a User I start game and chose right number
    When I tap {'14'} text
    And I wait {2} second
    Then I don't see {'Steps: 0'} text
    And I see {'Steps: 1'} text
    And I don't see {'Time: 00:00'} text

  Scenario: As a User I want to restart game
    When I tap {'14'} text
    And I tap {Icons.replay} icon
    Then I don't see {'Steps: 1'}
    And I see {'Steps: 0'} text

  Scenario: User Win
    When I tap {'14'} text
    And I wait {2} second
    And I tap {'15'} text
    And I wait
    Then I don't see {'15'} text
    And I see {'Congratulation!'} text


