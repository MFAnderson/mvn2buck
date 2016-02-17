require_relative 'hash_finder'

class Dependency
  attr_reader :group_id, :artifact_id, :version, :gav, :hash
  def initialize(group_id, artifact_id, version)
    @group_id = group_id
    @artifact_id = artifact_id
    @version = version
    @gav = "#{group_id}:#{artifact_id}:#{version}"
  end
  def to_s
    @gav
  end

  def resolve_sha1
    @hash = HashFinder.get_sha1(self)
  end
end
