public class Chark extends Player {

	public Chark(int posx, int posy, int index, SurvivalGame game) {
		super(100, 4, posx, posy, index, game);

		this.myString = "C" + Integer.toString(index);
        if((this.index+1)==(this.game.getN()/2)){
            this.equipment = new Wand(this);
        }
        else
            this.equipment = new Axe(this);

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

	@Override
	public void askForMove() {
		// TODO Auto-generated method stub
        if(this.equipment instanceof Weapon){
            Axe weapon=(Weapon)this.equipment;
            System.out.println(String.format("You are a Chark (C%d) using Axe. (Range: %d, Damage: %d)",this.index,
			weapon.getRange(), weapon.getEffect()));
            super.askForMove();
        }
        else if(this.wand instanceof Wand){
            System.out.println(String.format("You are a Chark (C%d) using Wand. (Range %d, Healing effect: %d)", this.index, 
				this.wand.getRange(),
				this.wand.getEffect()));
            super.askForMoveHeal();
        }
		
	}
}
