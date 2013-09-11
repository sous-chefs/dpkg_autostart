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
        begin
          node.run_context.resource_collection.lookup('dpkg_autostart[bin_file]')
          true
        rescue Chef::Exceptions::ResourceNotFound
          bin = Chef::Resource::DpkgAutostart.new('bin_file', node.run_context)
          bin.action :create
          node.run_context.resource_collection.unshift(bin)
        end
      end
    end
  end
end
