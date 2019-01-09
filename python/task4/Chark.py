from Player import Player
from Pos import Pos
from Axe import Axe
from Wand import Wand
class Chark(Player):
    def __init__(self,posx,posy,index,game):
        super(Chark,self).__init__(100,4,posx,posy,index,game)
        self.myString="C"+str(index)
        if((self.index+1)==(self.game.n/2)):
            #print self.myString,"you are using wand"
            self.equipment=Wand(self)
        else:
            self.equipment=Axe(self)
    def teleport(self):
        super(Chark,self).teleport()
        self.equipment.enhance()
    
    def askForMove(self):
        if (isinstance(self.equipment,Axe)):
            string="You are a Chark (C"+str(self.index)+") using Axe. (Range: "+str(self.equipment.getRange())+", Damage: "+str(self.equipment.getEffect())+")"
            print string
            super(Chark,self).askForMove()
        elif (isinstance(self.equipment,Wand)):
            string="You are a Chark (C"+str(self.index)+") using Wand. (Range: "+str(self.equipment.getRange())+", Healing effect: "+str(self.equipment.getEffect())+")"
            print string
            super(Chark,self).askForMoveHeal()