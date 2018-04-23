
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
  },
  setTrigger: function(id, cb) {
    exec(cb, null, PLUGIN_NAME, 'setTrigger', [id]);
  },
  getFrames: function(id, cb) {
    exec(cb, null, PLUGIN_NAME, 'getFrames', [id]);
  }
};

module.exports = MinewBeaconPlus;
