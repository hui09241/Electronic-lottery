applicants : public (map(uint,address))
temp : public (uint)

numApplicants : public (uint)
    
isrepeatable : public (bool) 
    
winnerInd : public (uint)
winnerAddress : public (address)

owner : public (address)

timestamp : public (uint)

donate : public (uint)
whodonate : public (address)
multi_num : public (uint)

@public 
def __init__():
    self.isrepeatable = True
    self.multi_num = 0
    self.owner=msg.sender
    self.numApplicants=0

@public
def enter():
    if owner!=msg.sender:
        self.applicants[self.numApplicants]=msg.sender
        self.numApplicants++


tempnum : public (uint256)
tempnum = self.numApplicants+self.multi_num
@public
def hold():
    self.timestamp=block.timestamp
    
    self.winnerInd=self.timestamp%(self.numApplicants + self.multi_num)
    self.winnerAddress=self.applicants[self.winnerInd]

    if self.isrepeatable == False :
        for i in range self.numApplicants+self.multi_num :
            if self.applicants[i]==self.applicants[self.winnerInd] :
                delete(self.applicants[i])
        for k in range (self.numApplicants+self.multi_num-1,0,-1):
            for j in range (0,k-1,1):
                if self.applicants[j]==0x0000000000000000000000000000000000000000 and self.applicants[j+1]!=0x0000000000000000000000000000000000000000
                    self.applicants[j]=self.applicants[j+1]
                    delete(self.applicants[j+1])
        self.multi_num=0
        self.numApplicants-=1

@public
def switchmode():
    if self.isrepeatable == True :
        self.isrepeatable = False
    else:
        self.isrepeatable = True

@public
def change_num(address who,uint multi):
    self.multi_num=multi
    for i in range self.numApplicants :
        if who==self.applicants[i] :
            self.temp=i
            break
    for i in range (self.numApplicants,self.numApplicants+self.multi,1)
        self.applicants[j]=self.applicants[temp]

@public
@payable
def feedback_chance():
    self.owner.transfer(msg.value)
    self.donate=msg.value
    self.whodonate=msg.sender

    
