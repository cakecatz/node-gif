// Generated by CoffeeScript 1.8.0
(function() {
  var p, piet;

  p = console.log;

  require('./utility').use();

  piet = {
    init: function(opts) {
      var ZERO, newGIF, preGIF;
      ZERO = 0x00;
      preGIF = [0x47, 0x49, 0x46, 0x38, 0x39, 0x61];

      /* Logical Screen Descriptor */
      preGIF.addBytes([opts.width, ZERO]);
      preGIF.addBytes([opts.height, ZERO]);
      preGIF.push(parseInt(this.readFlags(opts), 2));
      preGIF.push(ZERO);
      preGIF.push(ZERO);

      /* Global Color Table */
      preGIF.addBytes([255, 255, 255]);
      preGIF.addBytes([255, 0, 0]);
      preGIF.addBytes([0, 0, 255]);
      preGIF.addBytes([0, 0, 0]);

      /* Graphics Control Extension */
      preGIF.push(0x21);
      preGIF.push(0xF9);
      preGIF.push(0x04);
      preGIF.push(ZERO);
      preGIF.addBytes([ZERO, ZERO]);
      preGIF.push(ZERO);
      preGIF.push(ZERO);

      /* Image Descriptor */
      preGIF.push(0x2C);
      preGIF.addBytes([0x00, 0x00]);
      preGIF.addBytes([0x00, 0x00]);
      preGIF.addBytes([0x0A, 0x00]);
      preGIF.addBytes([0x0A, 0x00]);
      preGIF.push(0x00);

      /* Local Color Table */

      /* Image Data */
      preGIF.addBytes([0x02, 0x16, 0x8C, 0x2D, 0x99, 0x87, 0x2A, 0x1C, 0xDC, 0x33, 0xA0, 0x02, 0x75, 0xEC, 0x95, 0xFA, 0xA8, 0xDE, 0x60, 0x8C, 0x04, 0x91, 0x4C, 0x01, 0x00]);

      /* Trailer */
      preGIF.push(0x3B);
      p(preGIF);
      newGIF = new Buffer(preGIF);
      this.render(newGIF, './new.gif');
      return newGIF;
    },
    bool2Bit: function(bool) {
      if (bool) {
        return '1';
      } else {
        return '0';
      }
    },
    render: function(buf, path) {
      var fd, fs;
      fs = require('fs');
      fd = fs.openSync(path, 'w');
      return fs.writeSync(fd, buf, 0, buf.length);
    },
    readFlags: function(opts) {
      var flagBits;
      flagBits = '';
      if (opts.GCTFlag != null) {
        flagBits += this.bool2Bit(opts.GCTFlag);
      } else {
        flagBits += '0';
      }
      if (opts.colorRes != null) {
        flagBits += opts.colorRes;
      } else {
        flagBits += '001';
      }
      if (opts.sortFlag != null) {
        flagBits += this.bool2Bit(opts.sortFlag);
      } else {
        flagBits += '0';
      }
      if (opts.sizeOfGCT != null) {
        flagBits += opts.sizeOfGCT;
      } else {
        flagBits += '001';
      }
      return flagBits;
    },
    who: function() {
      var pjson;
      pjson = require('../package.json');
      return "I am " + pjson.name + ' ' + pjson.version + ' :)';
    }
  };

  module.exports = piet;

}).call(this);