#!/usr/bin/env ruby1.9
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "lib")

require 'pk2000core'
require 'optparse'
require 'pp'

class OptParse
   def self.parse(args)
      options = {}
      mandatory = {:in => 'Please specify a filename'}
      opts = OptionParser.new do |opts|
	 opts.banner = "Usage: pkc.rb [options]"

	 opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
	    options[:verbose] = v
	 end

	 opts.on("-i", "--input FILE", "PK Sourcecode") do |f|
	    options[:in] = f
	 end

	 opts.on("-o", "--output", "Ruby Output") do |f|
	    options[:out] = f
	 end

	 opts.on_tail("-h", "--help", "Show this message") do
	    puts opts
	    exit
	 end

	 # Another typical switch to print the version.
	 opts.on_tail("--version", "Show version") do
	    puts OptionParser::Version.join('.')
	    exit
	 end 
      end
      opts.parse!(args)
      mandatory.each_pair do |o,error|
	 unless options[o]
	    puts error
	    exit 1
	 end
      end
      options[:out] ||= options[:in].gsub(/\..*$/, ".rb")
      options
   end
end

options = OptParse.parse(ARGV)
puts options if options[:verbose]
parser = Pk2000Parser.new
pkCode = File.open(options[:in]).read.gsub(" ", "")
pkCode.chop! if pkCode[-1] == "\n"
puts pkCode if options[:verbose]
tree = parser.parse(pkCode)
rbCode = tree.toRuby
puts rbCode if options[:verbose]
out = File.open(options[:out], 'w')
out << rbCode
out.close

