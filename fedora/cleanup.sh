#!/bin/sh

set -e

dnf remove -y gcc gtk2 python3-devel redhat-rpm-config
dnf clean all

rm -R /root/*
