  # encoding: UTF-8

  require 'csv'
  require 'pathname'
  require 'pp'
  require 'json'
  require_relative '../version'

  module Jsontocsv
    # Apollon bootstrap module
    module Convert
      DEFAULT_OPTIONS = {
        out_path: 'out.txt',
        delimiter: ','
      }

      class << self
        def convert(paths, opts = {})
        # main function to convert a list of json files in to their respective csv files
        # we first for each path convert the json file into an Array of Hash then we convert the array of hash to a csv file
        # Example:
        #   >> Jsontocsv::Convert.convert('data/one_user_1.json', {"d"=>";",
        #    :d=>";",
        #    "delimiter"=>";",
        #    :delimiter=>";"})
        #   => nil
        #
        # Arguments:
        #   paths: (String or Array of String)
        #   opts: (Object)
          paths = [paths] unless paths.is_a?(Array)
          paths.each do |path|

            begin
              json = load_file(path)
              if json.nil?
                next
              end

              headings = (json.length > 0) ? get_recursive_keys(json[0]) : []
              headings = headings.to_a

              tmp_opts = { out_path: "#{path}.csv" }
              process(json, headings, DEFAULT_OPTIONS.merge(opts).merge(tmp_opts))

            rescue Exception => e # rubocop:disable RescueException
              log_exception(e)
            end

          end
        end

        def get_recursive_keys(hash, nested_key=[])
        # get list of nested keys from a hash, return an Array of Array
        # Example:
        #   >> nested_hash = {
        #     "id": 0,
        #     "twitter": {
        #         "picture": "//twcdn.com/ad9e8cd3-3133-423e-8bbf-0602e4048c22.jpg"
        #      }
        #     }
        #   >> Jsontocsv::Convert.get_recursive_keys(nested_hash)
        #   => [[:id], [:twitter, :picture]]
        #
        # Arguments:
        #   hash: Hash
        #   nested_key: Array of previous parents keys
          hash.each_with_object([]) do |(k,v),keys|
            # Col filter
            next if ["score", "original_name"].include? k
            k = !nested_key.empty? ? [nested_key, k].flatten : [k]
            if v.is_a? Hash
              keys.concat(get_recursive_keys(v, k))
            else
              keys << k
            end
          end
        end

        def load_file(path)
        # load a json file return an array
        # Example:
        #   >> Jsontocsv::Convert.load_file('file.json')
        #   => {"id": 4}
        #
        # Arguments:
        #   path: Array of previous parents keys
          begin
            json = JSON.parse(File.open(path).read)

            if json.class == Hash
              raise "file " + path + " is an hash not an array of hash"
            end

            return json
          rescue Exception => e # rubocop:disable RescueException
            log_exception(e)
          end

          nil
        end

        def log_exception(e)
        # log if invalid json
          puts 'Invalid json, see error.txt'
          File.open('error.txt', 'wt') { |f| f.write(e.to_s) }
        end

        def process(json, headings, opts = DEFAULT_OPTIONS)
        # output csv file
        # Example:
        # Jsontocsv::Convert.process([
        #   {"id"=>0, "email"=>"colleengriffith@quintity.com"},
        #   {"id"=>1, "email"=>"maryellengriffin@ginkle.com"}
        #   ], 'data/output.csv',[["id"],
        #   ["email"]], {"help"=>false,
        #       :help=>false,
        #       "d"=>";",
        #       :d=>";",
        #       :out_path=> 'data/output.csv',
        #       "delimiter"=>";",
        #       :delimiter=>";"})
        # => nil
        # Arguments:
        #   json: Array of hash
        #   headings: Array of headers
        #   opts: Hash of options
          CSV.open(opts[:out_path], 'w',  :col_sep => opts[:d]) do |csv|
            csv << headings.map { |n| n.join('.') }
            json.map{ |x|
            row = headings.map do |h|
              v = x.dig(*h)
              v.is_a?(Array) ? v.join(',') : v
            end
            csv << row
              }
          end
        end

      end
    end
  end
