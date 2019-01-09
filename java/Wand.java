public class Wand {
	private static final int WAND_RANGE=5;
	private int WAND_EFFECT=5;
	private Player owner;
	
	public Wand(Player owner) {
		this.owner = owner;
	}
    
    public void enhance(){
        this.WAND_EFFECT += 5;
    }
	
	public void action(int posx, int posy){
        System.out.println("You are using wand healing " + posx + " " + posy + ".");
        if (this.owner.pos.distance(posx, posy)  <= this.WAND_RANGE) {
			// search for all targets with target coordinates.
			Player player = owner.game.getPlayer(posx, posy);

			if(player.getClass().getSimpleName().equals(this.owner.getClass().getSimpleName())) 
			{
                if(player.getHealth()<=0){
                    String temp=player.getString().charAt(1)+Integer.toString(player.getIndex());
                    player.setString(temp);
                    player.increaseHealth(this.WAND_EFFECT);
                }
                else{
                    player.increaseHealth(this.WAND_EFFECT);
                }
            
			}
            else{
                System.out.println("You are not allowed to heal your opponent race.");
            }
		} else {
			System.out.println("Out of reach.");
		}
    }

	public int getEffect() {
		return this.WAND_EFFECT;
	}

	public int getRange() {
		return this.WAND_RANGE;
	}
}