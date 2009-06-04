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

	 opts.on("-c", "--call", "Add a function call for direct execution ") do |v|
	    options[:call] = v
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

def getPk options
   parser = Pk2000Parser.new
   pkCode = File.open(options[:in]).read.gsub(" ", "").gsub("\n]", "]").gsub("[\n", "[").gsub("\n\n","\n")
   pkCode.chop! if pkCode[-1] == "\n"
   puts pkCode if options[:verbose]
   pkCode
end

def mkRb pkCode, options
   parser = Pk2000Parser.new
   tree = parser.parse(pkCode)
   rbCode = tree.toRuby
   puts rbCode if options[:verbose]
   rbCode
end

def writeOut rbCode, options
   out = File.open(options[:out], 'w')
   out << "$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')\nrequire 'pk2000core'\n\n"
   out << rbCode
   if options[:call]
      out << "\n"
      rbCode =~ /def (PK[0-9]*\(.*\))/
      name = $1
      name.gsub!(/v[0-9]/, "4")
      out << "\nputs "+name+".to_i"
   end
   out.close
end

options = OptParse.parse(ARGV)
puts options if options[:verbose]
writeOut(mkRb(getPk(options), options), options)

