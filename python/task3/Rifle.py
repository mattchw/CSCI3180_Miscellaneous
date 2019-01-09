from Weapon import Weapon
class Rifle(Weapon):
    def __init__(self,owner):
        self.RIFLE_RANGE=4
        self.RIFLE_INIT_DAMAGE=10
        
        self.AMMO_LIMIT=6
        self.AMMO_RECHARGE=3
        super(Rifle,self).__init__(self.RIFLE_RANGE,self.RIFLE_INIT_DAMAGE,owner)
        self.ammo=self.AMMO_LIMIT
        
    def enhance(self):
        self.ammo=min(self.AMMO_LIMIT,self.ammo+self.AMMO_RECHARGE)
    
    def action(self,posx,posy):
        string="You are using rifle attacking "+str(posx)+" "+str(posy)+"."
        print string
        print "Type how many ammos you want to use."
        ammoToUse=input()
        if(ammoToUse>self.ammo):
            print "You don't have that ammos."
            return
        if(self.owner.pos.distance(posx,posy)<=self.weaponRange):
            player=self.owner.game.getPlayer(posx,posy)
            if(player!=None):
                player.decreaseHealth(self.effect*ammoToUse)
                self.ammo-=ammoToUse
        else:
            print "Out of reach."
    def getAmmo(self):
        return self.ammo