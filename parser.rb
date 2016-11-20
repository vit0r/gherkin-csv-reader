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
        attr_reader :receiver
        private :receiver

        def initialize(receiver)
          @receiver = receiver
        end

        def read_csv_file(document)
          path = Pathname.new(File.absolute_path(document.uri)).dirname
          body = document.body
          skp_indexes = 9
          examples_index = body.index('Examples:') + skp_indexes
          file_name = (body[examples_index, body.length]).strip
          values = (CSV.read(path + file_name, {:col_sep => '|', headers: true})).to_s.gsub!(',', '|').strip
          new_body = document.body.gsub(file_name, values)
          return new_body
        end

        def document(document)
          if document.body.include? '.csv'
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
