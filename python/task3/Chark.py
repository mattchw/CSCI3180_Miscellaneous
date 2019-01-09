from Player import Player
from Pos import Pos
from Axe import Axe
class Chark(Player):
    def __init__(self,posx,posy,index,game):
        super(Chark,self).__init__(100,4,posx,posy,index,game)
        self.myString="C"+str(index)
        self.equipment=Axe(self)
    def teleport(self):
        super(Chark,self).teleport()
        self.equipment.enhance()
    
    def askForMove(self):
        string="You are a Chark (C"+str(self.index)+") using Axe. (Range: "+str(self.equipment.getRange())+", Damage: "+str(self.equipment.getEffect())+")"
        print string
        super(Chark,self).askForMove()