require 'tabtab'
require File.join(File.dirname(__FILE__), '..', 'tabtab_definitions')
require 'readline'
require 'shellwords'

module Downloads
  module Commands
    class Shell < Base
      def run
        Readline.completer_word_break_characters = ''
        Readline.completion_append_character = ' '
        Readline.completion_proc = lambda do |line|
          words = Shellwords.shellwords("downloads #{line}")
          words << '' if line.split('')[-1] == ' '
          previous_token, current_token = words[-2..-1]
          completions = TabTab::Definition['downloads'].extract_completions(previous_token, current_token, {})
          completions.map { |completion| (words[1..-2] + [completion]).join(' ') }
        end

        puts 'Type ctrl-d or quit to exit.'

        loop do
          line = Readline::readline('> ') || 'quit'
          next if line.strip == ''
          Readline::HISTORY.push(line)
          command = Downloads::Commands.lookup(line.split(' '))
          if command.valid?
            command.run
          else
            puts command.usage
          end
        end
      end
    end
  end
end
