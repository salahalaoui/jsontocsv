# frozen_string_literal: true

RSpec.describe Jsontocsv do
    it "CLI displays help" do
        expect { system %(jsontocsv help) }
        .to output(a_string_including("NAME"))
        .to_stdout_from_any_process
    end

    it "CLI displays convert help" do
        expect { system %(jsontocsv help convert) }
        .to output(a_string_including("NAME"))
        .to_stdout_from_any_process
    end

    it "CLI displays version help" do
        expect { system %(jsontocsv help) }
        .to output(a_string_including("NAME"))
        .to_stdout_from_any_process
    end

    it "CLI converts file" do
        expect { system %(jsontocsv convert data/users.json) }
        .to output(a_string_including("done"))
        .to_stdout_from_any_process
    end

  end
