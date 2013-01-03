Feature: Country Change
   In order to test the countries Dropdown
   I want to verify that changing the dropdown loads a new country's data

   Scenario: Change the Countries Dropdown
      Given I go to the Visamapper Site
      When I choose India on the countries dropdown
      Then the map of India should be highlighted in blue

