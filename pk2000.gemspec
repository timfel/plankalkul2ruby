Gem::Specification.new do |s|
  s.name = "pk2000"
  s.version = "0.0.6"
  s.authors = ["Tim Felgentreff"]
  s.date = "2009-06-13"
  s.description = "use Zuse's Plankalkül with Ruby"
  s.email = "tim@nada1.de"
  s.extra_rdoc_files = Dir["README.rdoc", "LICENSE"]
  s.files = Dir["LICENSE", "Rakefile", "README.rdoc", "**/*.rb"]
  s.has_rdoc = true
  s.homepage = "http://github.com/timfel/plankalkul2ruby"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.3.1"
  s.summary = s.description
  s.add_dependency("ruby2ruby")
  s.add_dependency("treetop")
  s.add_dependency("polyglot")
end
