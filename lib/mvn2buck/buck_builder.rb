require 'erubis'

class BuckBuilder

  def self.build_lib_file dependencies
    template = File.read(File.expand_path('../libs.erb', __FILE__))
    buck = Erubis::Eruby.new(template).result(dependencies: dependencies.values)
    File.open('BUCK_lib', 'w') { |f| f.write(buck) }
  end
end
