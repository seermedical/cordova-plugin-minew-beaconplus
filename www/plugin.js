
var exec = require('cordova/exec');

var PLUGIN_NAME = 'MinewBeaconPlus';

var MinewBeaconPlus = {
  echo: function(phrase, cb) {
    exec(cb, null, PLUGIN_NAME, 'echo', [phrase]);
  },
  bleStatus: function(cb) {
    exec(cb, null, PLUGIN_NAME, 'bleStatus', []);
  },
  startScan: function(phrase, cb) {
    exec(cb, null, PLUGIN_NAME, 'startScan', [phrase]);
  },
  getDate: function(cb) {
    exec(cb, null, PLUGIN_NAME, 'getDate', []);
  }
};

module.exports = MinewBeaconPlus;
