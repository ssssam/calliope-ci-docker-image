#!/bin/sh

set -e

# Install what we can from DNF.
dnf install -y dbus-x11 dconf glib2-devel libmediaart-devel meson python3-gobject python3-pytest python3-pytest-benchmark python3-pyyaml tracker tracker-miners

# Install the remaining deps from PyPI.
#
# Some dependencies contain C code, so we need a C toolchain available during this process.
# Non exhaustive list: splitstream
dnf install -y gcc python3-devel python3-pip redhat-rpm-config

pip3 install click jsonschema parsedatetime splitstream yoyo-migrations
pip3 install mutagen
pip3 install jinja2 lastfmclient lightfm musicbrainzngs spotipy
dnf install -y gstreamer1-plugins-good

# Documentation dependencies
dnf install -y python3-sphinx python3-sphinx-click

# The version of pylint packaged by Fedora is too old, at time of writing.
# We need 2.2.x to ensure Python 3.6 support.
pip3 install pylint

# lightfm requires libgomp, this prevents it being removed when we uninstall GCC
dnf mark install libgomp

# jinja2 requires python3-markupsafe, this prevents it being removed during cleanup.
dnf mark install python3-markupsafe

# lightfm and spotipy require python3-idna, this prevents it being removed during cleanup
dnf mark install python3-idna

# dbus-launch warns if there's no /etc/machine-idwarns if there's no /etc/machine-id..
systemd-machine-id-setup
