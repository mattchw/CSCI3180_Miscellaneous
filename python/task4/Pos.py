class Pos:
    def __init__(self,x,y):
        self.x=x
        self.y=y
    def distance(self,another):
        return (abs(self.x-another.x)+abs(self.y-another.y))
    def distance(self,x1,y1):
        return (abs(self.x-x1)+abs(self.y-y1))
    def setPos(self,x,y):
        self.x=x
        self.y=y
    def getX(self):
        return self.x
    def getY(self):
        return self.y