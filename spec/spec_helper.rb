require "pathname"
require 'ruby2ruby'
$LOAD_PATH.unshift Pathname.new(__FILE__).dirname.join("../lib").expand_path.to_s
require 'pk2000'
include Plankalkuel
