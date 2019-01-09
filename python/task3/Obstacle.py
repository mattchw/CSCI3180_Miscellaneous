import random
from Pos import Pos
class Obstacle(object):
    def __init__(self,posx,posy,index,game):
        self.pos=Pos(posx,posy)
        self.index=index
        self.game=game
    
    def getPos(self):
        return self.pos
    
    def teleport(self):
        randx=random.randint(0,(self.game.D-1))
        randy=self.game.D-randx-1
        while(self.game.positionOccupied(randx,randy)):
            randx=random.randint(0,(self.game.D-1))
            randy=self.game.D-randx-1
        self.pos.setPos(randx,randy)