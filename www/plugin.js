
var exec = require('cordova/exec');

var PLUGIN_NAME = 'MinewBeaconPlus';

var MinewBeaconPlus = {
  echo: function(phrase, cb) {
    exec(cb, null, PLUGIN_NAME, 'echo', [phrase]);
  },
  bleStatus: function(cb) {
    exec(cb, null, PLUGIN_NAME, 'bleStatus', []);
  },
  startScan: function(cb) {
    exec(cb, null, PLUGIN_NAME, 'startScan', []);
  },
  stopScan: function(cb) {
    exec(cb, null, PLUGIN_NAME, 'stopScan', []);
  },
  getDate: function(cb) {
    exec(cb, null, PLUGIN_NAME, 'getDate', []);
  }
};

module.exports = MinewBeaconPlus;
