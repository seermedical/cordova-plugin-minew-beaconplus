
var exec = require('cordova/exec');

var PLUGIN_NAME = 'MinewBeaconPlus';

var MinewBeaconPlus = {
  bleStatus: function(cb) {
    exec(cb, null, PLUGIN_NAME, 'bleStatus', []);
  },
  startScan: function(cb) {
    exec(cb, null, PLUGIN_NAME, 'startScan', []);
  },
  stopScan: function(cb) {
    exec(cb, null, PLUGIN_NAME, 'stopScan', []);
  }
};

module.exports = MinewBeaconPlus;
