from Player import Player
from Pos import Pos
from Rifle import Rifle
class Human(Player):
    def __init__(self,posx,posy,index,game):
        super(Human,self).__init__(80,2,posx,posy,index,game)
        self.myString="H"+str(index)
        self.equipment=Rifle(self)
    def teleport(self):
        super(Human,self).teleport()
        self.equipment.enhance()
    def distance(self,posx,posy):
        pass
    def askForMove(self):
        string="You are a human (H"+str(self.index)+") using Rifle. (Range: "+str(self.equipment.getRange())+", Ammo #: "+str(self.equipment.getAmmo())+", Damage per shot: "+str(self.equipment.getEffect())+")"
        print string
        super(Human,self).askForMove()