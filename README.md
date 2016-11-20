# Cucumber-Ruby-Parser-CSV outline scenaries
    
    Cucumber-Ruby Parser CSV for cucumber-core-1.5.0
  
    #replace file parser.rb in -> ruby_dir/li/ruby/gems/2.3.0/gems/cucumber-core-1.5.0/lib/cucumber/core/gherkin

    #Feature example:
      Feature: Find Vitor
        Scenario Outline: Fulano age is 68
          Given Name <Name>
          Given Age <Age>
          ...
          Examples:
            cucumber_project_init/feature/data.csv
                 
     #File data.csv format:
       |Name|Age|
       |Fulano|50|
       |Fulano1|68|
