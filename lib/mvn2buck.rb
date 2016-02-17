require 'nokogiri'
require_relative 'dependency'
require_relative 'hash_finder'

class Mvn2Buck

  def self.main
    `mvn help:effective-pom -Doutput=/tmp/effective.xml`
    pom = File.open('/tmp/effective.xml') { |f| Nokogiri::XML(f) }
    dependencies = pom.xpath('/xmlns:project/xmlns:dependencies/xmlns:dependency')
    depData = {'compile' => [], 'test' => [], 'provided' => []}
    dependencies.each do |dep|
      groupId = dep.xpath('./xmlns:groupId').text
      artifactId = dep.xpath('./xmlns:artifactId').text
      version = dep.xpath('./xmlns:version').text
      scope = dep.xpath('./xmlns:scope').text
      dependency = Dependency.new(groupId, artifactId, version)
      dependency.resolve_sha1
      depData[scope] <<  dependency
    end
    depData
  end
end
