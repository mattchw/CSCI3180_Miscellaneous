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
class Gomoku:
    def __init__(self):
        #Create two players and initialize other instance variables.
        self.player1=1
        self.player2=2
        self.turn=1
        self.gameBoard=[[0 for x in range(9)]for y in range(9)]
        for x in range(0,9):
            for y in range(0,9):
                self.gameBoard[x][y]=' '
        
    def createPlayer(self,symbol,playerNum):
        #Create a player (human- or computer-controlled) with corresponding symbol (O OR X) and player number (1 or 2) by prompting the user.
        if symbol=='O':
            if playerNum==1:
                self.player1=Human(symbol,self.gameBoard)
            elif playerNum==2:
                self.player1=Computer(symbol,self.gameBoard)
            
        if symbol=='X':
            if playerNum==1:
                self.player2=Human(symbol,self.gameBoard)
            elif playerNum==2:
                self.player2=Computer(symbol,self.gameBoard)
           
    def startGame(self):
        #Start a new game and play until winning/losing or draw.
        print "Please choose player 1 (O):"
        print "1. Human"
        print "2. Computer Player"
        choice=input("Your choice is: ")
        if choice==1:
            print "Player O is Human."
        elif choice==2:
            print "Player O is Computer."
        self.createPlayer('O',choice)
        print("")
        
        print "Please choose player 2 (X):"
        print "1. Human"
        print "2. Computer Player"
        choice=input("Your choice is: ")
        if choice==1:
            print "Player X is Human."
        elif choice==2:
            print "Player X is Computer."     
        self.createPlayer('X',choice) 
        
        self.printGameBoard()
        while (self.turn!=0):
            if self.turn==1:
                print "Player O's turn!"
                r,c=self.player1.nextMove();
                self.gameBoard[r-1][c-1]=self.player1.PlayerSymbol
            elif self.turn==2:
                print "Player X's turn!"
                r,c=self.player2.nextMove();
                self.gameBoard[r-1][c-1]=self.player2.PlayerSymbol
                
            self.printGameBoard()
            if (self.checkWin()==True)|(self.checkTie()==True):
                self.turn=0
                
            if self.turn==1:
                self.turn=2
            elif self.turn==2:
                self.turn=1
        
    def printGameBoard(self):
        #Print out the game board in the command line window.
        print "  | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |"
        for x in range(0,9):
            print ("---------------------------------------")
            print (x+1),"|",self.gameBoard[x][0],"|",self.gameBoard[x][1],"|",self.gameBoard[x][2],"|",self.gameBoard[x][3],"|",self.gameBoard[x][4],"|",self.gameBoard[x][5],"|",self.gameBoard[x][6],"|",self.gameBoard[x][7],"|",self.gameBoard[x][8],"|"
        print ("---------------------------------------")
        
    def checkWin(self):
        #Check if any player has won the game.
        #check horizontal
        for x in range(0,9):
            playerO=0
            playerX=0
            for y in range(0,9):
                if playerO>=5:
                    print "Game ends. Player O wins"
                    return True
                elif playerX>=5:
                    print "Game ends. Player X wins"
                    return True
                if self.gameBoard[x][y]=='O':
                    playerO+=1
                    playerX=0
                elif self.gameBoard[x][y]=='X':
                    playerX+=1
                    playerO=0
                else:
                    playerO=0
                    playerX=0        
        #check vertical
        for x in range(0,9):
            playerO=0
            playerX=0
            for y in range(0,9):
                if playerO>=5:
                    print "Game ends. Player O wins"
                    return True
                elif playerX>=5:
                    print "Game ends. Player X wins"
                    return True
                if self.gameBoard[y][x]=='O':
                    playerO+=1
                    playerX=0
                elif self.gameBoard[y][x]=='X':
                    playerX+=1
                    playerO=0
                else:
                    playerO=0
                    playerX=0  
        #check diagonal from top-left to bottome-right
        check=0
        playerO=0
        playerX=0
        while check<5:
            playerO=0
            playerX=0
            for x in range(0,9):
                if playerO>=5:
                    print "Game ends. Player O wins"
                    return True
                elif playerX>=5:
                    print "Game ends. Player X wins"
                    return True
                
                if (x+check)>8:
                    break
                if self.gameBoard[x+check][x]=='O':
                    playerO+=1
                    playerX=0
                elif self.gameBoard[x+check][x]=='X':
                    playerX+=1
                    playerO=0
                else:
                    playerO=0
                    playerX=0
            check+=1
            
        check=0
        while check<5:
            playerO=0
            playerX=0
            for x in range(0,9):
                if playerO>=5:
                    print "Game ends. Player O wins"
                    return True
                elif playerX>=5:
                    print "Game ends. Player X wins"
                    return True
                
                if (x+check)>8:
                    break
                if self.gameBoard[x][x+check]=='O':
                    playerO+=1
                    playerX=0
                elif self.gameBoard[x][x+check]=='X':
                    playerX+=1
                    playerO=0
                else:
                    playerO=0
                    playerX=0
            check+=1
        #check diagonal from top-right to bottome-left
        check=0
        while check<5:
            reset=8
            playerO=0
            playerX=0
            for x in range(0,9):
                if playerO>=5:
                    print "Game ends. Player O wins"
                    return True
                elif playerX>=5:
                    print "Game ends. Player X wins"
                    return True
                
                if (x+check)>8:
                    break
                if self.gameBoard[x+check][reset]=='O':
                    playerO+=1
                    playerX=0
                elif self.gameBoard[x+check][reset]=='X':
                    playerX+=1
                    playerO=0
                else:
                    playerO=0
                    playerX=0
                reset-=1
                
            check+=1
            
        check=0
        while check<5:
            reset=8
            playerO=0
            playerX=0
            for x in range(0,9):
                if playerO>=5:
                    print "Game ends. Player O wins"
                    return True
                elif playerX>=5:
                    print "Game ends. Player X wins"
                    return True
                
                if (reset-check)<0:
                    break
                if self.gameBoard[x][reset-check]=='O':
                    playerO+=1
                    playerX=0
                elif self.gameBoard[x][reset-check]=='X':
                    playerX+=1
                    playerO=0
                else:
                    playerO=0
                    playerX=0
                reset-=1
                
            check+=1 
        return False
               
    def checkTie(self):
        #Check if the game is ending in a tie.
        for x in range(0,9):
            for y in range(0,9):
                if self.gameBoard[x][y]==' ':
                    return False
        print "Game ties."
        return True
                    
import abc
class Player(object):
    __metaclass__ = abc.ABCMeta
    def __init__(self, symbol, gameboard):
        #Initialize the player with its symbol X or O and corresponding gameboard.
        self.PlayerSymbol=symbol
        self.gameBoard=gameboard
        
    @abc.abstractmethod
    def nextMove(self):
        #An abstract method to be implemented in subclasses, which returns the row and column (1-9 for each) of the next move.
        return
        
class Human(Player):
    def nextMove(self):
        row, col = raw_input("Type the row and col to put the disc: ").split()
        while(self.gameBoard[int(row)-1][int(col)-1]!=' '):
            print "Invalid input!"
            row, col = raw_input("Type the row and col to put the disc: ").split()
        return int(row),int(col)
        
class Computer(Player):
    def nextMove(self):
        row=random.randint(1,9)
        col=random.randint(1,9)
        while(self.gameBoard[row-1][col-1]!=' '):
            row=random.randint(1,9)
            col=random.randint(1,9)
        return row,col
       
game=Gomoku()
game.startGame()