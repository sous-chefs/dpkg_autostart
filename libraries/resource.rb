require 'chef/resource'

class Chef
  class Resource
    class DpkgAutostart < Chef::Resource
      allowed_actions [:nothing, :create]

      resource_name :dpkg_autostart
      provides :dpkg_autostart

      default_action :nothing

      def initialize(name, run_context = nil)
        super
        @provider = Chef::Provider::DpkgAutostart
      end

      def allow(val)
        node.run_state[:dpkg_autostart_disabled] ||= []
        node.run_state[:dpkg_autostart_disabled].push(name) unless val
        context = node.run_context
        begin
          context.resource_collection.lookup('dpkg_autostart[bin_file]')
          true
        rescue Chef::Exceptions::ResourceNotFound
          bin = Chef::Resource::DpkgAutostart.new('bin_file', context)
          bin.action :create
          if context.resource_collection.respond_to?(:insert)
            context.resource_collection.insert(bin)
          else
            context.resource_collection.push(bin)
          end
        end
      end
    end
  end
end
