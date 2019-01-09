#
# CSCI3180 Principles of Programming Languages
#
# --- Declaration ---
#
# I declare that the assignment here submitted is original except for source
# material explicitly acknowledged. I also acknowledge that I am aware of
# University policy and regulations on honesty in academic work, and of the
# disciplinary guidelines and procedures applicable to breaches of such policy
# and regulations, as contained in the website
# http://www.cuhk.edu.hk/policy/academichonesty/
#
# Assignment 2
# Name : Wong Cho Hin
# Student ID : 1155070355
# Email Addr : wongch6@cse.cuhk.edu.hk
#
import random
from Pos import Pos
from Player import Player
from Chark import Chark
from Human import Human
from Obstacle import Obstacle
from Weapon import Weapon
from Axe import Axe
from Rifle import Rifle
class SurvivalGame:
    def __init__(self):
        #dimension of board
        self.D=10
        #number of obstacles
        self.O=2
        self.n=0
        self.teleportObjects=[]
        
    def printBoard(self):
        printObject=[[0 for i in range(self.D)]for j in range(self.D)]
        for i in range(0,self.D):
            for j in range(0,self.D):
                printObject[i][j]="  "
                
        for i in range(0,self.n):
            pos=self.teleportObjects[i].getPos()
            printObject[pos.getX()][pos.getY()]=self.teleportObjects[i].getName()
            
        for i in range(self.n,(self.n+self.O)):
            pos=self.teleportObjects[i].getPos()
            printObject[pos.getX()][pos.getY()]="O"+str(i-self.n)
        
        #printing
        string=" "
        for i in range(0,self.D):
            string+="| "+str(i)+"  "
        string+="|"
        print string
        
        string=""
        i=0
        while (i<self.D*5.5):
            string+="-"
            i+=1
        print string
        
        for row in range(0,self.D):
            string=""
            string+=str(row)
            for col in range(0,self.D):
                string+="| "+printObject[row][col]+" "
            string+="|"
            print string
            string=""
            i=0
            while (i<self.D*5.5):
                string+="-"
                i+=1
            print string
        
    def positionOccupied(self,randx,randy):
        for obj in self.teleportObjects:
            pos=obj.getPos()
            if (pos.getX()==randx)and(pos.getY()==randy):
                return True
            
        return False
    
    def getPlayer(self,randx,randy):
        for obj in self.teleportObjects:
            if(isinstance(obj,Player)):
                pos=obj.getPos()
                if(pos.getX()==randx)and(pos.getY()==randy):
                    return obj
        return None
        
    #---    
    def init(self):
        print "Welcome to Kafustrok. Light blesses you. \nInput number of players: (a even number)"
        self.n=input()
        self.teleportObjects=[0 for x in range(self.n+self.O)]
        #create N/2 Humans
        i=0
        while i<(self.n/2):
            self.teleportObjects[i]=Human(0,0,i,self)
            self.teleportObjects[i+self.n/2]=Chark(0,0,i,self)
            i+=1
        #create O obstacles. You cannot stand there   
        i=0
        while i<self.O:
            self.teleportObjects[i+self.n]=Obstacle(0,0,i,self)
            i+=1
        
    def gameStart(self):
        turn=0
        numOfAlivePlayers = self.n
        while numOfAlivePlayers>1:
            if turn==0:
                for obj in self.teleportObjects:
                    obj.teleport()
                print "Everything gets teleported.."
            self.printBoard()
            t=self.teleportObjects[turn]
            if(t.health>0):
                t.askForMove()
                print ""
            turn = (turn+1)%self.n
            numOfAlivePlayers=0
            for i in range(0,self.n):
                if(self.teleportObjects[i].health>0):
                    numOfAlivePlayers+=1
        print "Game over."
        self.printBoard()
            

        
        
game=SurvivalGame()
game.init()
game.gameStart()