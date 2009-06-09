Gem::Specification.new do |s|
  s.name = "pk2000"
  s.version = "0.0.1"
  s.authors = ["Tim Felgentreff"]
  s.date = "2009-06-08"
  s.description = "use Zuse's Plankalkül with Ruby"
  s.email = "tim@nada1.de"
  s.extra_rdoc_files = Dir["README.rdoc", "LICENSE"]
  s.files = Dir["LICENSE", "Rakefile", "README.rdoc", "**/*.rb"]
  s.has_rdoc = false
  s.homepage = "http://timfel.github.com/plankalkul2ruby"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.3.1"
  s.summary = s.description
  s.add_dependency("ruby2ruby", "treetop", "polyglot")
end
