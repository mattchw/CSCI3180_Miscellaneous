import abc
class Weapon(object):
    __metaclass__ = abc.ABCMeta
    def __init__(self,weaponRange,damage,owner):
        self.weaponRange=weaponRange
        self.effect=damage
        self.owner=owner
        
    @abc.abstractmethod    
    def action(self,posx,posy):
        return
    @abc.abstractmethod
    def enhance(self):
        return
    
    def getEffect(self):
        return self.effect
    def getRange(self):
        return self.weaponRange