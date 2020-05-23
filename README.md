# dpkg_autostart cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/dpkg_autostart.svg)](https://supermarket.chef.io/cookbooks/dpkg_autostart)
[![Build Status](https://img.shields.io/circleci/project/github/sous-chefs/atom/master.svg)](https://circleci.com/gh/sous-chefs/atom)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

`dpkg` likes to start services after installation as the Debian convention
dictates. This can be annoying and problematic, especially when you don't
want services to be immediately started before custom configuration can
be applied. Instead of disabling all services from auto starting on installation
as the `dpkg_deb_unautostart` cookbook does, lets allow specific services
to be targeted.

## Usage

### Resource

Include the cookbook as a dependency in your metadata:

```ruby
depends 'dpkg_autostart'
```

Then, within your recipe, disable the service with the resource:

```ruby
dpkg_autostart 'mysql-server' do
  allow false
end
```

That's it. When `dpkg` attempts to start the service after install (generally
via `apt`) it will be instructed not to. This allows the proper configuration
files to be generated, and the service to be started after everything is
ready.

### Attribute

You can also provide a list of services to disable via node attribute. Add
the default recipe to the run list:

```ruby
run_list 'recipe[dpkg_autostart]'
```

and set the services you want to restrict from auto starting:

```ruby
node.default['dpkg_autostart']['disabled_services'] = ['mysql-server', 'apache2']
```

## Related

- deb_pkg_unautostart: <http://ckbk.it/deb_pkg_unautostart>

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
