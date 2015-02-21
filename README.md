pimatic-ble
===========

Pimatic Plugin that allows multiple ble sources on pimatic

Configuration
-------------
Add the plugin to the plugin section:

    {
      "plugin": "ble"
    },

There is no devices provided by this plugin it acts as a
common discovery for multiple devices, this is due to noble
blocking procedure in order to discover bluetooth low energy
devices
