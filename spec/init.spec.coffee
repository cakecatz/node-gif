piet = require '../lib/piet'
p = console.log

describe "require", ->
  it "require piet.js", ->
    expect(piet.who()).toBe('I am Piet.js 0.0.1 :)')

describe "Create GIF", ->
  it "init gif create", ->

    p piet.init({
      width: 10
      height: 10
      GCTFlag: true
    })
