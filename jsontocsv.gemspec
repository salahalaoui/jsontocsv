# frozen_string_literal: true

require 'rubygems'

$:.push File.expand_path("../lib", __FILE__)

require 'jsontocsv/version.rb'


Gem::Specification.new do |spec|
  spec.name = "jsontocsv"
  spec.version = Jsontocsv::VERSION
  spec.authors = ["Salah Alaoui"]
  spec.email = ["salaoui@onestock-retail.com"]

  spec.summary = "Convert JSON files to CSV files"
  spec.description = "This Ruby lib aims at converting JSON files composed of arrays of objects (all following the same schema) into CSV files where one line equals one object."
  spec.homepage = "https://github.com/salahalaoui"
  spec.license = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.files = `git ls-files`.split("\n")

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'gli', '~> 2.20', '>= 2.20.1'
  spec.add_dependency 'json', '~> 2.6.1'
  spec.add_dependency 'rake', '~> 13.0', '>= 13.0.6'

  spec.add_development_dependency 'coveralls', '~> 0.7', '>= 0.7.0r'
  spec.add_development_dependency 'rspec', '~> 3.0', '>= 3.0.0'
  spec.add_development_dependency 'rubocop', '~> 0.24', '>= 0.24.0'
  spec.add_development_dependency 'simplecov', '~> 0.8', '>= 0.8.2'

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
