@trac_0001
@committed
Feature: Visiting the home page
  In order to something when I go to the website
  As a user
  I want to see some blurb about takkatak

  Scenario: Visiting the home page
    When I go to the homepage
    Then I should see "Takkatak: Rhythms for everybody"
