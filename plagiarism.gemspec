Gem::Specification.new do |gem|
  gem.name        = 'plagiarism'
  gem.version     = '0.1.0'
  gem.summary     = "Wrapper for the Copyscape Premium API"
  gem.description = "Wrapper for the Copyscape Premium API"
  gem.homepage    = "https://github.com/zohlgren/plagiarism"
  gem.authors     = ["Zach Ohlgren"]
  gem.email       = "zach@ohlgren.me"

  gem.add_dependency 'nokogiri'
  gem.add_development_dependency 'rspec-core'


  gem.files = `git ls-files`.split("\n")
  gem.test_files    = gem.files.grep(/^spec/)
  gem.require_path = "lib"

end