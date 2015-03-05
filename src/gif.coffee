p = console.log

require('./utility').use()

piet = {
  init: (opts)->
    ZERO = 0x00
    preGIF = [0x47,0x49,0x46,0x38,0x39,0x61]

    ### Logical Screen Descriptor ###

    # set width and hegith
    preGIF.addBytes [opts.width, ZERO]
    preGIF.addBytes [opts.height, ZERO]

    # packed byte
    preGIF.push parseInt(@readFlags(opts), 2)

    # background color index
    preGIF.push ZERO

    # pixel aspect ration
    preGIF.push ZERO

    ### Global Color Table ###
    preGIF.addBytes [255, 255, 255]
    preGIF.addBytes [255,   0,   0]
    preGIF.addBytes [  0,   0, 255]
    preGIF.addBytes [  0,   0,   0]

    ### Graphics Control Extension ###

    # Extension Introducer - Always 21
    preGIF.push 0x21

    # Graphic Control Label - Always F9
    preGIF.push 0xF9

    # Byte size
    # TODO
    preGIF.push 0x04

    # Packed Field
    # - 000 000 00
    # TODO
    preGIF.push ZERO

    # Delay Time
    # TODO
    preGIF.addBytes [ZERO, ZERO]

    # Transparent Color Index
    # TODO
    preGIF.push ZERO

    # Block Terminator - Always 00
    preGIF.push ZERO

    ### Image Descriptor ###

    # Image Seperator - Always 2C
    preGIF.push 0x2C

    # Image Left
    preGIF.addBytes [0x00, 0x00]

    # ImageTop
    preGIF.addBytes [0x00, 0x00]

    # Image Width
    preGIF.addBytes [0x0A, 0x00]

    # Image height
    preGIF.addBytes [0x0A, 0x00]

    # Packed Field
    preGIF.push 0x00

    ### Local Color Table ###

    ### Image Data ###
    #preGIF.addBytes [0x02, 0x16, 0x8C, 0x2D, 0x99, 0x87, 0x2A, 0x1C, 0xDC, 0x33 ,0xA0, 0x02,
    #  0x75, 0xEC, 0x95, 0xFA, 0xA8, 0xDE, 0x60, 0x8C, 0x04, 0x91, 0x4C, 0x01, 0x00]

    preGIF.addBytes [0x21, 0x01, 0x0c, 0x00, 0x00, 0x00, 0x00, 0x64, 0x00, 0x64,
      0x00 ,0x14, 0x14, 0x01, 0x00, 0x0B, 0x68, 0x65, 0x6C, 0x6C, 0x6F, 0x20, 0x77,
      0x6F, 0x20, 0x77, 0x6F, 0x72, 0x6C, 0x64, 0x00]

    ### Trailer ###

    preGIF.push 0x3B

    p preGIF

    #newGIF = new Buffer preGIF
    newGIF = new Buffer preGIF

    @render newGIF, './new.gif'

    return newGIF

  bool2Bit: (bool)->
    if bool
      return '1'
    else
      return '0'

  render: (buf, path)->
    fs = require 'fs'
    fd = fs.openSync path, 'w'
    fs.writeSync fd, buf, 0, buf.length

  readFlags: (opts)->
    flagBits = ''
    # global color table flag - 1bit
    # This value is N
    # actual table size is 2^(N + 1)
    # if N = 1, table size get 2^(1 + 1) = 4

    if opts.GCTFlag?
      flagBits += @bool2Bit opts.GCTFlag
    else
      flagBits += '0'

    # color resolution - 3bits
    if opts.colorRes?
      flagBits += opts.colorRes
    else
      flagBits += '001'

    # sort flag - 1bit
    if opts.sortFlag?
      flagBits += @bool2Bit opts.sortFlag
    else
      flagBits += '0'

    # size of global color table - 3bits
    if opts.sizeOfGCT?
      flagBits += opts.sizeOfGCT
    else
      flagBits += '001'

    return flagBits

  who: ->
    pjson = require '../package.json'
    return "I am " + pjson.name + ' ' + pjson.version + ' :)'

}

module.exports = piet