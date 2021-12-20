# encoding: utf-8

require 'gli'
require 'pathname'
require 'pp'

require_relative 'shared'
require_relative '../version'

def launch(argv = ARGV)
  run(argv)
end

include GLI::App

program_desc "jsontocsv #{Jsontocsv::VERSION}"

module Jsontocsv
  module Cli
    # CLI Application
    class App
      extend Jsontocsv::Cli::Shared

      cmds = File.absolute_path(File.join(File.dirname(__FILE__), 'cmd'))
      Dir.glob(cmds + '/*.rb').each do |file|
        require file
      end

      program_desc 'Apollon CLI'

      def main(argv = ARGV)
        launch(argv)
      end
    end
  end
end

launch
