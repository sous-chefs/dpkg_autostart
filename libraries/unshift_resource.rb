require 'chef/resource_collection'

class Chef
  class ResourceCollection
    def unshift(resource)
      @resources.unshift(resource)
      @resources_by_name.each_key do |key|
        @resources_by_name[key] += 1
      end
      @resources_by_name[resource.to_s] = 0
    end
  end
end
