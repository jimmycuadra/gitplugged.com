chai      = require "chai"
chaiJq    = require "chai-jquery"
sinon     = require "sinon"
sinonChai = require "sinon-chai"

chai.use(chaiJq)
chai.use(sinonChai)

global.expect = chai.expect
global.sinon = sinon
