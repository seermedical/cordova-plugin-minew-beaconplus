Minew-Beacon-Plus
======

MASTER: Just a Cordova plugin template from here https://github.com/rrostt/cordova-plugin-template
DEVELOPMENT: Everything is here so far. Developing a Cordova plugin on iOS and Android to communicate with the Minew BeaconPlus Framework

# Minew Resources

Our R&D Department just finished D15N ibeacon nRF52, the trigger function is to broadcast when press twice or three times and it can be set on our configured APP.

- [SDK for android and ios](http://docs.beaconyun.com/#beaconplus) (we use BeaconPlus)
- [Minew Libraries and Framework](https://api.beaconyun.com/d/77deeea95a2b43adb30a/) (password minewtech)
- [Technical Spec Sheet](https://drive.google.com/open?id=1yXWo228CiBvQ4O6Gef9jlulHsnytxJf-). This contains info to download the Minew app and configure beacon properties (all of which we *should* be able to implement programmatically)

# [Eddystone Plugin](https://github.com/evothings/cordova-eddystone)
This is an existing cordova plugin for working with eddystone beacons (Google standard). We can use this plugin to access advertisting data from the Minew buttons. 

We can see fields:
- RSSI:  received signal strength indicator (RSSI), a negative integer reporting the signal strength in decibels. May have the value of 127, which means undefined RSSI value
- txPower: signal strength in decibels, factory-measured at a range of 0 meters.
- name: model/make. may be null
- address: this uniquely identifies a beacon
- url, beaconID, namespaceID: non-unique, set by manufacturer
- voltagea: battery voltage, in millivolts, or 0 (zero) if device is not battery-powered.
- temperature: from button sensor, updated every advertising frame
- advertising count: number of advertising frames sent
- d-sec count: number of decimal seconds

There is a dictionary called advertisementData. It contains:
- kCBAdvDataServiceUUIDs: Array of strings, the UUIDs of services advertised by the device. Formatted according to RFC 4122, all lowercase.
- kCBAdvDataServiceData: Dictionary of strings to strings. The keys are service UUIDs. The values are base-64-encoded binary data.

Our service UUID is `0000feaa-0000-1000-8000-00805f9b34fb` data comes through in strings such as `AOgAESIzRFVmd4iZqrvM3e7/`, but these appear to be nonsense when decoded as base-64-binary.

The Eddystone plugin cannot be used to connect to a beacon (only read advertised frames). The Minew framework does have connection options, which is why we may need to write our own plugin to achieve required function.

# [iOS Plugin](https://github.com/seermedical/cordova-plugin-minew-beaconplus)
I have been writing a plugin for iOS that adds the relevant Minew framework to a cordova project. I am using the iOS SDK provided by Minew to develop this. So far we can:
- Locate buttons
- Read frames (although not consistently like with the eddystone plugin)
- Connect to device (goes from status 1 to 11)

### Triggers
These might be the key!
- TriggerTypeMotionLater
- TriggerTypeBtnPushLater
- TriggerTypeBtnReleaLater
- TriggerTypeBtnStapLater
- TriggerTypeBtnDtapLater
- TriggerTypeBtnTtapLater

I have written a function for our plugin that writes a TriggerTypeBtnStapLater (single press of button) trigger to slot 5. The first button click initiates an advertising frame to appear in slot 5, however the frame is continuously advertising. I have asked Minew to clarify how to read trigger data from the frame, and how to detect subsequent button presses.

# Android Plugin
TODO
