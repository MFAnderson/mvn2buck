require 'nokogiri'
require 'mvn2buck/dependency'
require 'mvn2buck/hash_finder'
require 'mvn2buck/buck_builder'

class Mvn2Buck

  def self.main
    #`mvn help:effective-pom -Doutput=/tmp/effective.xml`
    pom = File.open('/tmp/effective.xml') { |f| Nokogiri::XML(f) }
    pom.remove_namespaces!
    dependencies = pom.xpath('//project/dependencies/dependency')
    externalDeps = {}
    internalDeps = {}
    dependencies.each do |dep|
      groupId = dep.xpath('./groupId').text
      artifactId = dep.xpath('./artifactId').text
      version = dep.xpath('./version').text
      scope = dep.xpath('./scope').text
      dependency = Dependency.new(groupId, artifactId, version)
      dependency.resolve_sha1
      externalDeps[dependency.hash] = dependency unless dependency.hash.nil?
    end
    BuckBuilder.build_lib_file externalDeps
    externalDeps
  end
end
