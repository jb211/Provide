pragma solidity ^0.4.2;

contract DominantAssuranceContract {
    address public entrepreneur;
    mapping(address => uint256) pledgerBalance;
    uint256 public pledgeCountGoal;
    uint256 public pledgeAmount;
    uint256 public refundPercentage;
    uint256 public pledgeCount;
    uint256 public pledgeDeadline;

    //constructor
    constructor (uint256 _pledgeCountGoal, uint256 _pledgeAmount,uint256 _refundPercentage, uint256 _campaignLength) {
        entrepreneur = msg.sender;
        pledgeAmount = _pledgeAmount;
        pledgeCountGoal = _pledgeCountGoal;
        refundPercentage = _refundPercentage;
        pledgeDeadline = now + (_campaignLength * 1 days);
        beneficiary = _beneficiary;
    }

    //pledge
    function pledge (uint256 amount) public payable {
        require(now < pledgeDeadline, "Campaign deadline has been reached");
        require(pledgerBalance[msg.sender] == 0, "You have already pledged");
        require(msg.value == pledgeAmount, "Pledge amount is incorrect");


        uint256 addPayoff = amount + (refundPercentage / 100); // check integer division rules

        pledgerBalance[msg.sender] += amount + addPayoff;
        pledgeCount += 1;
    }


    function claimFunds() public {
        require(msg.sender == entrepreneur, "Only the entrepreneur can claim");
        require(pledgeCount >= pledgeCountGoal, "Campaign has not succeeded yet")
        require(now > deadline, "The campaign is not over yet")

        msg.sender.transfer(address(this).balance);

    }

    function getRefund() public {
        require(now > deadline, "The campaign is not over");
        require(pledgeCount < pledgeCountGoal, "The campaign did not fail");

        uint256 amount = pledgerBalance[msg.sender];
        pledgerBalance[msg.sender] = 0;
        msg.sender.transfer(amount);
    }



}

