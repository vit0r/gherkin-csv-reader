#Gherkin Parser Outline Scenaries CSV for cucumber-core-1.5.0
  
    #replace file parser.rb in -> ruby_dir/li/ruby/gems/2.3.0/gems/cucumber-core-1.5.0/lib/cucumber/core/gherkin

    #Feature: Eather

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
					 
     #File data.csv or data1.csv format:
       | start | eat | left |
       |  12   |  5  |  7   |
	   |  20   |  5  |  15  |


