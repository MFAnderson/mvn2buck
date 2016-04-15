Gem::Specification.new do |s|
  s.name = 'mvn2buck'
  s.version = '0.0.0'
  s.summary = "Mvn2Buck"
  s.executables << 'mvn2buck'
  s.add_runtime_dependency "nokogiri",
    ["~> 1.6"]
  s.add_runtime_dependency "erubis",
    ["~> 2.7"]
  s.description = 'Builds BUCK projects from Maven POMs, including 3rd party dependencies'
  s.authors = ["Max Anderson"]
  s.files = ["lib/mvn2buck.rb", "lib/mvn2buck/dependency.rb", 
    "lib/mvn2buck/hash_finder.rb", "lib/mvn2buck/buck_builder.rb", "lib/mvn2buck/libs.erb"]
end
