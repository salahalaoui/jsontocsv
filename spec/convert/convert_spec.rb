# frozen_string_literal: true
require 'fileutils'

require_relative '../../lib/jsontocsv/convert/convert'
RSpec.describe Jsontocsv::Convert do
    it "can load json file" do
    expect(Jsontocsv::Convert.load_file('data/one_user_1.json')).to eq([
        {"id"=>0, "email"=>"colleengriffith@quintity.com"},
        {"id"=>1, "email"=>"maryellengriffin@ginkle.com"}
        ])
    end

    it "can get recursive keys" do
        nested_hash = {
            "id": 0,
            "email": "colleengriffith@quintity.com",
            "tags": [
            "consectetur",
            "quis"
            ],
            "profiles": {
            "facebook": {
                "id": 0,
                "picture": "//fbcdn.com/a2244bc1-b10c-4d91-9ce8-184337c6b898.jpg"
            },
            "twitter": {
                "id": 0,
                "picture": "//twcdn.com/ad9e8cd3-3133-423e-8bbf-0602e4048c22.jpg"
            }
            }
        }

        expect(Jsontocsv::Convert.get_recursive_keys(nested_hash)).to eq([[:id],
            [:email],
            [:tags],
            [:"profiles", :facebook, :id],
            [:"profiles", :facebook, :picture],
            [:"profiles", :twitter, :id],
            [:"profiles", :twitter, :picture]])
    end

    it "output csv file from an array of hash" do

        Jsontocsv::Convert.process([
            {"id"=>0, "email"=>"colleengriffith@quintity.com"},
            {"id"=>1, "email"=>"maryellengriffin@ginkle.com"}
            ], 'data/output.csv',[["id"],
            ["email"]], {"help"=>false,
                :help=>false,
                "d"=>";",
                :d=>";",
                :out_path=> 'data/output.csv',
                "delimiter"=>";",
                :delimiter=>";"})
        expect(FileUtils.compare_file('data/output.csv', 'data/valid_output.csv')).to be_truthy
    end

    it "can convert json file to csv" do

        Jsontocsv::Convert.convert('data/one_user_1.json', {"help"=>false,
            :help=>false,
            "d"=>";",
            :d=>";",
            "delimiter"=>";",
            :delimiter=>";"})
        expect(FileUtils.compare_file('data/one_user_1.json.csv', 'data/valid_one_user_1.json.csv')).to be_truthy
    end

    it "can convert multiple json files to csv files" do

        Jsontocsv::Convert.convert('data/one_user_1.json', {"help"=>false,
            :help=>false,
            "d"=>";",
            :d=>";",
            "delimiter"=>";",
            :delimiter=>";"})
        expect(FileUtils.compare_file('data/one_user_1.json.csv', 'data/valid_one_user_1.json.csv')).to be_truthy

        Jsontocsv::Convert.convert('data/one_user_2.json', {"help"=>false,
            :help=>false,
            "d"=>";",
            :d=>";",
            "delimiter"=>";",
            :delimiter=>";"})
        expect(FileUtils.compare_file('data/one_user_2.json.csv', 'data/valid_one_user_2.json.csv')).to be_truthy
    end
end
