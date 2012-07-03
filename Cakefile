{spawn} = require "child_process"

task "spec", "Run the Mocha specs", ->
  args = [
    "--compilers"
    "coffee:coffee-script"
    "--require"
    "coffee-script"
    "--require"
    "spec/javascripts/spec_helper"
    "--colors"
    "--bail"
    "spec/javascripts"
  ]

  mocha = spawn "node_modules/.bin/mocha", args

  mocha.stdout.on "data", (data) ->
    process.stdout.write(data)

  mocha.stderr.on "data", (data) ->
    process.stderr.write(data)

  mocha.stdin.end()
