require 'gherkin/parser'
require 'gherkin/token_scanner'
require 'gherkin/errors'
require 'cucumber/core/gherkin/ast_builder'
require 'cucumber/core/ast'
require 'pathname'
require 'csv'

module Cucumber
  module Core
    module Gherkin
      ParseError = Class.new(StandardError)

      class Parser
        EXT_CSV = '.csv'
        attr_reader :receiver
        private :receiver
        attr_reader :csv_options

        def initialize(receiver)
          @receiver = receiver
          @csv_options = {
              :col_sep => '|',
              headers: true,
              :unconverted_fields => true,
              :skip_blanks => true,
              :encoding => 'utf-8'
          }
        end

        def read_csv_file(document)
          path = Pathname.new(File.absolute_path(document.uri)).dirname
          file_names = document.body.scan(/\S.+.csv/)
          body = document.body.to_s
          file_names.each do |name|
            values = (CSV.read(path + name, @csv_options)).to_s.strip.gsub!(',', '|')
            body = body.gsub(name, values)
          end
          return body
        end

        def document(document)
          if document.body.include? Parser::EXT_CSV
            body = read_csv_file(document)
          else
            body = document.body
          end

          parser = ::Gherkin::Parser.new
          scanner = ::Gherkin::TokenScanner.new(body)
          core_builder = AstBuilder.new(document.uri)

          begin
            result = parser.parse(scanner)

            receiver.feature core_builder.feature(result)
          rescue *PARSER_ERRORS => e
            raise Core::Gherkin::ParseError.new("#{document.uri}: #{e.message}")
          end
        end

        def done
          receiver.done
          self
        end

        private

        PARSER_ERRORS = ::Gherkin::ParserError

      end
    end
  end
end
