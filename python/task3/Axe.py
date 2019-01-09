from Weapon import Weapon
class Axe(Weapon):
    def __init__(self,owner):
        self.AXE_RANGE=1
        self.AXE_INIT_DAMAGE=40
        super(Axe,self).__init__(self.AXE_RANGE, self.AXE_INIT_DAMAGE, owner)
        
    def enhance(self):
        self.effect+=10
        
    def action(self,posx,posy):
        string="You are using axe attacking "+str(posx)+" "+str(posy)+"."
        print string
        #print self.owner.pos.distance(posx,posy)
        if(self.owner.pos.distance(posx,posy)<=self.weaponRange):
            player=self.owner.game.getPlayer(posx,posy)
            if(player!=None):
                player.decreaseHealth(self.effect)
        else:
            print "Out of reach."