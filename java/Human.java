public class Human extends Player {
	
	public Human(int posx, int posy, int index, SurvivalGame game) {
		super(80, 2, posx, posy, index, game);
		
		this.myString = 'H' + Integer.toString(index);
        if((this.index+1)==(this.game.getN()/2)){
            this.equipment = new Wand(this);
        }
        else
            this.equipment = new Rifle(this);
		
	}

	public void teleport() {
		super.teleport();
        if(this.equipment instanceof Wand){
            Wand wand=(Wand)this.equipment;
            wand.enhance();
        }
        else if(this.equipment instanceof Weapon){
            Weapon weapon=(Weapon)this.equipment;
            weapon.enhance();
        }
	}
	
	public void distance(int posx, int posy)
	{
		
	}
	
	@Override
	public void askForMove() {
		// TODO Auto-generated method stub
        if(this.equipment instanceof Weapon){
            System.out.println(String.format("You are a human (H%d) using Rifle. (Range %d, Ammo #: %d, Damage per shot: %d)", this.index, 
				this.equipment.getRange(),((Rifle)this.equipment).getAmmo(),
				this.equipment.getEffect() ));
            super.askForMove();
        }
        else if(this.wand instanceof Wand){
            System.out.println(String.format("You are a human (H%d) using Wand. (Range %d, Healing effect: %d)", this.index, 
				this.wand.getRange(),
				this.wand.getEffect()));
            super.askForMoveHeal();
        }
		
	}

}
