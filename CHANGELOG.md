# dpkg_autostart Cookbook CHANGELOG

This file is used to list changes made in each version of the dpkg_autostart cookbook.

## 0.4.4 - *2021-08-31*

- Standardise files with files in sous-chefs/repo-management

## 0.4.3 - *2021-06-01*

- resolved cookstyle error: test/cookbooks/test/metadata.rb:4:25 convention: `Layout/TrailingEmptyLines`

## 0.4.2 - *2020-11-27*

- Fix regression introduced in 0.4.1, of undefined method `action` being received

## 0.4.1 (2020-09-16)

- resolved cookstyle error: libraries/provider.rb:13:7 refactor: `ChefModernize/ActionMethodInResource`
- resolved cookstyle error: libraries/provider.rb:17:7 refactor: `ChefModernize/ActionMethodInResource`

## 0.4.0 (2020-06-18)

- Restore Chef Infra Client < 16 compatibility

## v0.3.1 (2020-06-02)

- resolved cookstyle error: libraries/resource.rb:8:7 warning: `ChefDeprecations/ResourceUsesOnlyResourceName`

## v0.3.0 (2020-05-22)

- Transferred ownership of this cookbook to Sous Chefs
- Updated the resource to define the resource name via the resource DSL
- Updated the resource to define the allowed actions and default action via the resource DSL
- Removed support for Chef 10
- Added source_url / issues_url to the metadata.rb
- Added supports 'debian' and 'ubuntu' the to metadata.rb
- Added chefignore file to limit files uploaded to the Chef Server
- Added testing with GitHub Actions
- Added Delivery local mode configuration for local testing
- Added various documentation files
- Added a Berksfile

## v0.2.0

_NOTE_: Release introduces minor breaking change due to updated interaction with resource collection.

- Fix script syntax in bin file (#7 thanks @hamann!)
- Allow multiple services and actions (#7 thanks @hamann!)
- Use `ResourceCollection#insert` when adding bin resource
  - _NOTE_: This may require updating resource locations or adding the default recipe to the beginning of the run list

## v0.1.12

- Be a noop except on debian family

## v0.1.10

- Add support for upstart services (thanks @bkw)

## v0.1.8

- Add support for Chef 10 (#3)
- Properly update `resource_collection` when unshifting (#4)
  - Thanks @mpasternacki

## v0.1.6

- Fix version number

## v0.1.4

- Use "heavyweight" resource/provider
- Fix execution error on initial runs (#2)

## v0.1.2

- Add explicit `:create` action to template

## v0.1.0

- Initial commit
