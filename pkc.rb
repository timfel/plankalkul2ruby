#!/usr/bin/env ruby1.9

require 'pk2000core'
require 'optparse'

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
      mandatory.each do |o,error|
	 puts error unless options[o]
	 exit 1
      end
      options[:out] ||= options[:in].gsub(/\..*$/, ".rb")
   end
end

options = OptParse.parse(ARGV)

parser = Pk2000Parser.new
pkCode = File.open(options[:in]).read
tree = parser.parse(code)
rbCode = tree.toRuby
puts rbCode if options[:verbose]
out = File.open(options[:out], 'w')
out << rbCode
out.close

