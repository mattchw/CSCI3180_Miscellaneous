import random
from Pos import Pos
class Player(object):
    def __init__(self,healthCap,mob,posx,posy,index,game):
        self.MOBILITY=mob
        self.healthCap=healthCap
        self.health=self.healthCap
        self.pos=Pos(posx,posy)
        self.equipment=0
        self.index=index
        self.myString=""
        self.game=game
        
    def getPos(self):
        return self.pos
    
    def teleport(self):
        randx=random.randint(0,(self.game.D-1))
        randy=random.randint(0,(self.game.D-1))
        while(self.game.positionOccupied(randx,randy)):
            randx=random.randint(0,(self.game.D-1))
            randy=random.randint(0,(self.game.D-1))
        self.pos.setPos(randx,randy)
    
    def increaseHealth(self,h):
        if((self.health+h)>self.healthCap):
            self.health=self.healthCap
        else:
            self.health+=h
    
    def decreaseHealth(self,h):
        self.health-=h
        if (self.health<=0):
            self.health=0
            self.myString = "C" + self.myString[0]
            
    def getName(self):
        return self.myString
    
    def askForMove(self):
        string="Your health is "+str(self.health)+". Your position is ("+str(self.pos.getX())+","+str(self.pos.getY())+"). Your mobility is "+str(self.MOBILITY)+"."
        print string
        print "You now have following options: "
        print "1. Move"
        print "2. Attack"
        print "3. End the turn"
        a=input()
        
        if(a==1):
            print "Specify your target position (Input 'x y')."
            x, y = raw_input().split()
            posx=int(x)
            posy=int(y)
            if(self.pos.distance(posx,posy)>self.MOBILITY):
                print "Beyond your reach. Staying still."
            elif(self.game.positionOccupied(posx,posy)):
                print "Position occupied. Cannot move there."
            else:
                self.pos.setPos(posx,posy)
                self.game.printBoard()
                print "You can now \n1.attack\n2.End the turn"
                choice=input()
                if(choice==1):
                    print "Input position to attack. (Input 'x y')"
                    ax, ay = raw_input().split()
                    attx=int(ax)
                    atty=int(ay)
                    self.equipment.action(attx,atty)
        elif(a==2):
            print "Input position to attack."
            ax, ay = raw_input().split()
            attx=int(ax)
            atty=int(ay)
            self.equipment.action(attx,atty)
        elif(a==3):
            return
    
    def askForMoveHeal(self):
        string="Your health is "+str(self.health)+". Your position is ("+str(self.pos.getX())+","+str(self.pos.getY())+"). Your mobility is "+str(self.MOBILITY)+"."
        print string
        print "You now have following options: "
        print "1. Move"
        print "2. Heal"
        print "3. End the turn"
        a=input()
        
        if(a==1):
            print "Specify your target position (Input 'x y')."
            x, y = raw_input().split()
            posx=int(x)
            posy=int(y)
            if(self.pos.distance(posx,posy)>self.MOBILITY):
                print "Beyond your reach. Staying still."
            elif(self.game.positionOccupied(posx,posy)):
                print "Position occupied. Cannot move there."
            else:
                self.pos.setPos(posx,posy)
                self.game.printBoard()
                print "You can now \n1.heal\n2.End the turn"
                choice=input()
                if(choice==1):
                    print "Input position to heal. (Input 'x y')"
                    hx, hy = raw_input().split()
                    healx=int(hx)
                    healy=int(hy)
                    self.equipment.action(healx,healy)
        elif(a==2):
            print "Input position to heal."
            hx, hy = raw_input().split()
            healx=int(hx)
            healy=int(hy)
            self.equipment.action(healx,healy)
        elif(a==3):
            return