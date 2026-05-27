#FILESEXTRAPATHS:prepend:rpi := "${THISDIR}/${BPN}:"
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = "file://0001-Make-Ignore-returned-error-on-make-install.patch"

