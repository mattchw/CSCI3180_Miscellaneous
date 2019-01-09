class Wand(object):
    def __init__(self,owner):
        self.wandRange=5
        self.effect=5
        self.owner=owner
        
    def enhance(self):
        self.effect+=5
        
    def action(self,posx,posy):
        string="You are using wand healing "+str(posx)+" "+str(posy)+"."
        print string
        if(self.owner.pos.distance(posx,posy)<=self.wandRange):
            player=self.owner.game.getPlayer(posx,posy)
            if(isinstance(self.owner,player.__class__)):
                if(player.health<=0):
                    player.myString=player.myString[1]+str(player.index)
                    player.increaseHealth(self.effect)
                
                else:
                    player.increaseHealth(self.effect)
            else:
                print "You are not allowed to heal your opponent race."
        else:
            print "Out of reach."
    
    def getEffect(self):
        return self.effect
    def getRange(self):
        return self.wandRange