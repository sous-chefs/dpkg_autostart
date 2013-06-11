actions :set
default_action :set

def allow(val)
  node.run_state[:dpkg_autostart_disabled] ||= []
  node.run_state[:dpkg_autostart_disabled].push(name) unless val
  begin
    node.run_context.resource_collection.lookup('template[dpkg_autostart_file]')
  rescue Chef::Exceptions::ResourceNotFound
    template = Chef::Resource::Template.new('dpkg_autostart_file', node.run_context)
    template.cookbook 'dpkg_autostart'
    template.source 'policy-rc.d.erb'
    template.path '/usr/sbin/policy-rc.d'
    template.mode 0755
    # Force this to the front of the line
    node.run_context.resource_collection.all_resources.unshift(template)
  end
end
