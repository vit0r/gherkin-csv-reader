# cucumber-ruby-parser-csv
    
    cucumber ruby parser csv for cucumber-core-1.5.0
  
    replace file parser.rb in -> ruby_dir/li/ruby/gems/2.3.0/gems/cucumber-core-1.5.0/lib/cucumber/core/gherkin

    #Feature example:
      
      #encoding: utf-8
      
      Feature: Find Vitor

        Scenario Outline: Vitor when age is 31
          Given <Name>
          Given <Age>
          Examples:
            path_to_file/data.csv
          
       
     #File data.csv format:
       |Name|Age|
       |Vitor|31|
       |Vitor1|32|
