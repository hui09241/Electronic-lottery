pragma solidity ^0.4.11;
contract Lottery{
    mapping(uint => address ) public applicants;
    uint public temp;
    
    uint public numApplicants;
    
    bool public isrepeatable=true;
    
    address public winnerAddress;
    uint public winnerInd;
    
    address public owner;
    
    uint public timestamp;
    
    uint public donate;
    address public whodonate;
    uint public multi_num=0;
    
    modifier onlyOwner(){
        require(msg.sender==owner);
        _;
    }
    function Lottery(){
        numApplicants=0;
        owner=msg.sender;
    }
    
    function enter() public{
        if(owner!=msg.sender)
        {
            applicants[numApplicants+multi_num]=msg.sender;
            numApplicants++;
        }
    }
    
    function hold() public onlyOwner{
        
        timestamp=block.timestamp;
        
        winnerInd=timestamp%(numApplicants+multi_num);
        winnerAddress=applicants[winnerInd];
        
        if(isrepeatable==false)
        {
            for(uint i=0;i<(numApplicants+multi_num);i++)
            {
                if(applicants[i]==applicants[winnerInd])
                    delete(applicants[i]);
            }
            
            for(uint k=(numApplicants+multi_num-1);k>0;k--)
            {
                for(uint j=0;j<=k-1;j++)
                {
                    if((applicants[j]==0x0000000000000000000000000000000000000000) && (applicants[j+1]!=0x0000000000000000000000000000000000000000))
                    {
                        applicants[j]=applicants[j+1];
                        delete(applicants[j+1]);
                    }
                }
            }
            multi_num=0;
            numApplicants--;
        }
    }
    
    function switchmode () public
    {
        if(isrepeatable==true)
            isrepeatable=false;
        else
            isrepeatable=true;
    }
    
    function change_num(address who ,uint multi) public
    {
        multi_num=multi;
        for(uint i=0;i<numApplicants;i++)
        {
            if(who==applicants[i])
            {
                temp=i;
                break;
            }
        }
        for(uint j=numApplicants;j<numApplicants+multi;j++)
        {
            applicants[j]=applicants[temp];
        }
    }
    
    function feedback_chance() public payable{
        owner.transfer(msg.value);
        donate=msg.value;
        whodonate=msg.sender;
    }
}