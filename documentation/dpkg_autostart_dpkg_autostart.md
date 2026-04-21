# dpkg_autostart_dpkg_autostart

Manages the global `/usr/sbin/policy-rc.d` policy hook used by Debian package
scripts so selected services do not auto-start during `dpkg` operations.

## Actions

| Action    | Description                                                 |
| --------- | ----------------------------------------------------------- |
| `:create` | Creates or updates `/usr/sbin/policy-rc.d`. Default action. |

## Properties

| Property          | Type            | Default             | Description                                                             |
| ----------------- | --------------- | ------------------- | ----------------------------------------------------------------------- |
| `service_name`    | `String`        | Resource name       | Service name to match in `policy-rc.d` (name property).                 |
| `allow`           | `true`, `false` | `false`             | When `false`, the named service is blocked from the configured actions. |
| `disable_actions` | `Array`         | `%w(start restart)` | Actions denied by the global policy script for this run.                |

## Examples

### Block a package-managed service from auto-starting

```ruby
dpkg_autostart 'mysql-server' do
  allow false
end
```

### Block multiple services

```ruby
dpkg_autostart 'mysql-server' do
  allow false
end

dpkg_autostart 'apache2' do
  allow false
end
```

### Extend the blocked action list

```ruby
dpkg_autostart 'mysql-server' do
  allow false
  disable_actions %w(start restart reload)
end
```
