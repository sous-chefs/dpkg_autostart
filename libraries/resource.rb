require 'chef/resource'

class Chef
  class Resource
    class DpkgAutostart < Chef::Resource

      def initialize(name, run_context=nil)
        super
        @resource_name = :dpkg_autostart
        @provider = Chef::Provider::DpkgAutostart
        @action = :nothing
        @allowed_actions = [:nothing, :create]
      end

      def allow(val)
        node.run_state[:dpkg_autostart_disabled] ||= []
        node.run_state[:dpkg_autostart_disabled].push(name) unless val
        chef_version = Gem::Version.new(Chef::VERSION)
        context = chef_version < Gem::Version.new('11.0.0') ? run_context : node.run_context
        begin
          context.resource_collection.lookup('dpkg_autostart[bin_file]')
          true
        rescue Chef::Exceptions::ResourceNotFound
          bin = Chef::Resource::DpkgAutostart.new('bin_file', context)
          bin.action :create
          if(context.resource_collection.respond_to?(:insert))
            context.resource_collection.insert(bin)
          else
            context.resource_collection.push(bin)
          end
        end
      end
    end
  end
end
