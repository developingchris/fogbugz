module Fogbugz
  class Project
    attr_accessor :name
    def self.build node
      proj = Project.new
      proj.name = node.sProject
      proj
    end
  end
end
