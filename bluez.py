#!/usr/bin/python

import dbus
from dbus.mainloop.glib import DBusGMainLoop
import gobject

import subprocess

# ID of the device we care about
DEV_ID = '00_1D_54_AB_DC_72'

dbus_loop = DBusGMainLoop()
bus = dbus.SystemBus(mainloop=dbus_loop)

# Figure out the path to the mouse
man = bus.get_object('org.bluez', '/')
iface = dbus.Interface(man, 'org.bluez.Manager')
adapterPath = iface.DefaultAdapter()

mouse = bus.get_object('org.bluez', adapterPath + '/dev_' + DEV_ID)
    # ^^^ I'm not sure if that's kosher. But it works.

def cb(iface=None, mbr=None, path=None):

    if ("org.bluez.mouse" == iface and path.find(DEV_ID) > -1):
        print 'iface: %s' % iface
        print 'mbr: %s' % mbr
        print 'path: %s' % path
        print "\n"
        print "matched"

        if mbr == "Connected":
            subprocess.call(['/home/mitch/mouse.sh'])
            print 'conn'

mouse.connect_to_signal("Connected", cb, interface_keyword='iface', member_keyword='mbr', path_keyword='path')
mouse.connect_to_signal("Disconnected", cb, interface_keyword='iface', member_keyword='mbr', path_keyword='path')

loop = gobject.MainLoop()
loop.run()
