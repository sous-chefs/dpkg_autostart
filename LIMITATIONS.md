# Limitations

## Package Availability

`dpkg` and the `invoke-rc.d` / `policy-rc.d` mechanism are distribution-provided on
Debian-family systems. This cookbook does not install `dpkg`; it manages the
policy hook that those package maintainer scripts consult.

### APT (Debian/Ubuntu)

* Debian 12 (Bookworm): `dpkg` is available from the standard archive for
  multiple architectures including `amd64` and `arm64`
* Debian 13 (Trixie): `dpkg` is available from the standard archive for
  multiple architectures including `amd64` and `arm64`
* Ubuntu 22.04 (Jammy): `dpkg` is available from the standard archive for
  multiple architectures including `amd64` and `arm64`
* Ubuntu 24.04 (Noble): `dpkg` is available from the standard archive for
  multiple architectures including `amd64` and `arm64`

There is no separate upstream vendor repository to configure for this cookbook.

## Architecture Limitations

* The underlying `dpkg` packages are published for more than one architecture on
  supported Debian and Ubuntu releases
* This cookbook's CI currently exercises Debian/Ubuntu container images on
  `amd64`; other architectures rely on upstream package availability rather than
  cookbook-specific coverage

## Source/Compiled Installation

No source build path is relevant for this cookbook. It manages
`/usr/sbin/policy-rc.d` and relies on the distro's native `dpkg` tooling.

## Known Issues

* This cookbook is only meaningful on Debian-family platforms because
  `policy-rc.d` is part of the `invoke-rc.d` contract used by Debian packaging
  scripts
* The policy file is global. If multiple `dpkg_autostart` resources specify
  `disable_actions`, the actions are merged into a single list for the generated
  `policy-rc.d` script
