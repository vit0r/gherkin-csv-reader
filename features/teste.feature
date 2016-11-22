Feature: Eather

  Scenario Outline: eating
    Given there are <start> cucumbers
    When I eat <eat> cucumbers
    Then I should have <left> cucumbers

    Examples:
      data.csv

  Scenario Outline: eating2
    Given there are <start> eating
    When I eat <eat> eating
    Then I should have <left> eating

    Examples:
      ./dir/data1.csv