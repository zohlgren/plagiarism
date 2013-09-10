Gem::Specification.new do |gem|
  gem.name        = 'plagiarism'
  gem.version     = '0.1.0'
  gem.summary     = "A Ruby wrapper for the Copyscape Premium API"
  gem.description = "Search for plagiarism and check your content for originality with Copyscape"
  gem.homepage    = "https://github.com/zohlgren/plagiarism"
  gem.authors     = ["Zach Ohlgren"]
  gem.email       = "zach@ohlgren.me"
  gem.license     = 'MIT'

  gem.add_dependency 'httparty'
  gem.add_dependency 'nokogiri'
  gem.add_dependency 'money'
  gem.add_development_dependency 'rspec-core'
  gem.add_development_dependency 'vcr'
  gem.add_development_dependency 'excon', '>= 0.22.0'
  gem.add_development_dependency 'webmock', '< 1.12.0'


  gem.files = `git ls-files`.split("\n")
  gem.test_files    = gem.files.grep(/^spec/)
  gem.require_path = "lib"

end