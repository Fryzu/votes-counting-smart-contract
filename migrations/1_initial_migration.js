const Ballot = artifacts.require("Ballot")

module.exports = function (deployer) {
  const candidates = ["0x4f62616d610000000000000000000000000000000000000000000000000000", "0x5472756d700000000000000000000000000000000000000000000000000000", "0x426964656e0000000000000000000000000000000000000000000000000000"].map(i => i.toString(32))
  deployer.deploy(Ballot, candidates)
}