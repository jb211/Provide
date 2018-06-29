var Election = artifacts.require("./Election.sol");

contract(Election, function (accounts) {
  it("initialized with two candidates", function() {
  return Election.deployed().then(function(instance) {
    return instance.candidatesCount();
  }).then(function(count) {
      assert.equal(count, 2);j
  });
});
});
