pragma solidity ^0.4.2;

contract DominantAssuranceContract {
    address public entrepreneur;
    uint256 public pledgesGoal;
    uint256 public totalPledges;
    uint256 public pledgesCount;
    uint256 pledgeDeadline;
    uint256 refundPercentage;
    mapping(address => uint256) public pledgeBalance;
    address beneficiary;

    constructor(uint256 lengthOfPledge, uint256 _goal, uint8 _refundPercentage, address _beneficiary) public payable {
        entrepreneur = msg.sender;
        beneficiary = _beneficiary;
        pledgesGoal = _goal;
        pledgeDeadline = now + (lengthOfPledge * 1 days);
        refundPercentage = _refundPercentage;
        pledgeBalance[entrepreneur] = msg.value;
        pledgesCount = 0;
    }

    function pledge(uint256 amount) public payable {
        require(now < pledgeDeadline, "The campaign is over");
        require(msg.value == amount, "The amount is incorrect");
        //require(msg.sender != owner,)

        uint256 payout = amount * (refundPercentage / 100);
        if (payout > pledgeBalance[entrepreneur]) {
            payout = pledgeBalance[entrepreneur];
        }

        pledgeBalance[entrepreneur] -= payout;
        pledgeBalance[msg.sender] += payout;
        totalPledges += amount;
        pledgesCount++;
    }

}
