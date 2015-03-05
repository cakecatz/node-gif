module.exports = {
  use: ->
    String.prototype.splitNum = (separator)->
      arr = []
      str = ''
      for c in this
        str += c
      pre = str.split separator
      for s in pre
        arr.push Number s

      return arr

    Number.prototype.toHex = (padding)->
      hexNum = this.toString(16)
      if hexNum.length < padding
        hexNum = Array(padding - hexNum.length + 1).join('0') + hexNum
      return '0x' + hexNum

    Array.prototype.addBytes = (arr)->
      for num in arr
        this.push num

}