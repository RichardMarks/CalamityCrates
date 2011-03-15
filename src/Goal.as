package  
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class Goal extends Entity 
	{
		static private var goalImage:Image;
		
		public function Goal(xPos:Number = 0, yPos:Number = 0) 
		{
			if (goalImage == null)
			{
				goalImage = new Image(Assets.GFX, new Rectangle(32 * 2, 0, 32, 32));
			}
			layer = 3;
			type = "goal";
			graphic = goalImage;
			
			var px:int = int(xPos / 32);
			var py:int = int(yPos / 32);
			
			x = px * 32;
			y = py * 32;
			
			setHitbox(goalImage.width, goalImage.height);
		}
	}
}