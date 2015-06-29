# v0.2.0
_NOTE_: Release introduces minor breaking change due to updated
	interaction with resource collection.
* Fix script syntax in bin file (#7 thanks @hamann!)
* Allow multiple services and actions (#7 thanks @hamann!)
* Use `ResourceCollection#insert` when adding bin resource
  * _NOTE_: This may require updating resource locations or adding the
	default recipe to the beginning of the run list

# v0.1.12
* Be a noop except on debian family

# v0.1.10
* Add support for upstart services (thanks @bkw)

# v0.1.8
* Add support for Chef 10 (#3)
* Properly update `resource_collection` when unshifting (#4)
  * Thanks @mpasternacki

# v0.1.6
* Fix version number

# v0.1.4
* Use "heavyweight" resource/provider
* Fix execution error on initial runs (#2)

# v0.1.2
* Add explicit `:create` action to template

# v0.1.0
* Initial commit
