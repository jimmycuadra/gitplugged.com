# Chai
chai = require "chai"
global.expect = chai.expect

# jQuery
global.jQuery = require "jquery"
global.$ = jQuery

# Sinon
global.sinon = require "sinon"

# Chai extensions
chai.use require "chai-jquery"
chai.use require "sinon-chai"
