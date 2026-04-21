# Migration Guide

This cookbook migrated from attribute-driven recipe setup to a single custom resource.

## Breaking change for operators upgrading older releases

This is a breaking change for any wrapper cookbook, role, or policy that
still includes `dpkg_autostart::default` or sets `node['dpkg_autostart']`
attributes. The recipe and attribute interfaces were removed, so existing
attribute-driven configuration must be rewritten to use `dpkg_autostart`
resources directly before you upgrade.

If you upgrade without making that change, the old recipe include and
attribute configuration will no longer manage `policy-rc.d` for your
services.

## What changed

* `attributes/default.rb` was removed.
* `recipes/default.rb` was removed.
* The old `libraries/` implementation was replaced by `resources/dpkg_autostart.rb`.
* The public interface is now the `dpkg_autostart` resource.

## How to migrate

Legacy pattern:

```ruby
include_recipe 'dpkg_autostart::default'

node.default['dpkg_autostart']['disabled_services'] = %w(mysql-server apache2)
```

Resource-first pattern:

```ruby
dpkg_autostart 'mysql-server' do
  allow false
end

dpkg_autostart 'apache2' do
  allow false
end
```

## Attribute migration

Move service-specific behavior into resource properties:

* blocked service name becomes the resource name
* blocked actions move to `disable_actions`
* allowing a service start uses `allow true`

Example:

```ruby
dpkg_autostart 'mysql-server' do
  allow false
  disable_actions %w(start restart reload)
end
```

## Important note

`policy-rc.d` is global on the node. Multiple `dpkg_autostart` resources are merged during the run, so model each service explicitly instead of using a cookbook-wide attribute list.
