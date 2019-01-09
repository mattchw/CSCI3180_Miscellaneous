from Player import Player
from Pos import Pos
from Rifle import Rifle
from Wand import Wand
class Human(Player):
    def __init__(self,posx,posy,index,game):
        super(Human,self).__init__(80,2,posx,posy,index,game)
        self.myString="H"+str(index)
        if((self.index+1)==(self.game.n/2)):
            self.equipment=Wand(self)
        else:
            self.equipment=Rifle(self)
    def teleport(self):
        super(Human,self).teleport()
        self.equipment.enhance()
    def distance(self,posx,posy):
        pass
    def askForMove(self):
        if (isinstance(self.equipment,Rifle)):
            string="You are a human (H"+str(self.index)+") using Rifle. (Range: "+str(self.equipment.getRange())+", Ammo #: "+str(self.equipment.getAmmo())+", Damage per shot: "+str(self.equipment.getEffect())+")"
            print string
            super(Human,self).askForMove()
        elif (isinstance(self.equipment,Wand)):
            string="You are a human (H"+str(self.index)+") using Wand. (Range: "+str(self.equipment.getRange())+", Healing effect: "+str(self.equipment.getEffect())+")"
            print string
            super(Human,self).askForMoveHeal()