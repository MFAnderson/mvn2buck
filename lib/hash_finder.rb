require 'net/http'

class HashFinder
  @@mvn_repo = "http://central.maven.org/maven2/"

  def self.get_sha1 dep
    url = "#{@@mvn_repo}#{dep.group_id.gsub(/\./, '/')}/#{dep.artifact_id}/#{dep.version}/#{dep.artifact_id}-#{dep.version}.jar.sha1"   
    res = Net::HTTP.get_response(URI(url))
    res.body.split.first if res.code.eql? "200" #hacking for messy hash files with extra info
  end

end
