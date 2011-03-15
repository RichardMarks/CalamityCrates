package  
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class Wall extends Entity 
	{
		static private var wallImage:Image;
		
		public function Wall(xPos:Number = 0, yPos:Number = 0) 
		{
			if (wallImage == null)
			{
				wallImage = new Image(Assets.GFX, new Rectangle(32, 0, 32, 32));
			}
			type = "wall";
			layer = 1;
			graphic = wallImage;
			
			var px:int = int(xPos / 32);
			var py:int = int(yPos / 32);
			
			x = px * 32;
			y = py * 32;
			
			setHitbox(wallImage.width, wallImage.height);
		}
	}
}