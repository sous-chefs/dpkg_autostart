# frozen_string_literal: true

provides :dpkg_autostart
unified_mode true

property :service_name, String, name_property: true
property :allow, [true, false], default: false, desired_state: false
property :disable_actions, Array,
         default: %w(start restart),
         desired_state: false,
         coerce: proc { |value| Array(value).map(&:to_s) }

default_action :create

action :create do
  return unless platform_family?('debian')
  return if new_resource.allow

  node.run_state[:dpkg_autostart_policy] ||= {
    disabled_services: [],
    disable_actions: [],
  }

  policy = node.run_state[:dpkg_autostart_policy]
  policy[:disabled_services] |= [new_resource.service_name]
  policy[:disable_actions] |= new_resource.disable_actions

  with_run_context :root do
    edit_resource(:template, '/usr/sbin/policy-rc.d') do
      cookbook 'dpkg_autostart'
      source 'policy-rc.d.erb'
      mode '0755'
      variables(
        disable_actions: policy[:disable_actions].sort,
        disabled_services: policy[:disabled_services].sort
      )
      action :nothing
      delayed_action :create
    end
  end
end
