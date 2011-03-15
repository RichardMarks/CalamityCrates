package  
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class Crate extends Entity 
	{
		static private var crateImage:Image;
		static private var crateOnGoalImage:Image;
		
		private var amIOnAGoal:Boolean = false;
		
		public function Crate(xPos:Number = 0, yPos:Number = 0) 
		{
			if (crateImage == null)
			{
				crateImage = new Image(Assets.GFX, new Rectangle(32 * 3, 0, 32, 32));
				crateOnGoalImage = new Image(Assets.GFX, new Rectangle(32 * 3, 0, 32, 32));
				crateOnGoalImage.color = 0xFF00FF00;
			}
			layer = 2;
			type = "crate";
			graphic = crateImage;
			
			var px:int = int(xPos / 32);
			var py:int = int(yPos / 32);
			
			x = px * 32;
			y = py * 32;
			
			setHitbox(crateImage.width, crateImage.height);
			
			// if I am on a goal, change my state
			OnGoal = (null != collide("goal", x, y));
		}
		
		public function get OnGoal():Boolean { return amIOnAGoal; }
		public function set OnGoal(value:Boolean):void
		{
			amIOnAGoal = value;
			graphic = (amIOnAGoal) ? crateOnGoalImage : crateImage;
		}
		
		public function MoveUp():Boolean
		{
			// if there is a wall above me, we cannot move
			if (collide("wall", x, y - 32))
			{
				trace("crate collided with wall, unable to move crate up");
				return false;
			}
			
			// if there is a crate above me, we cannot move
			if (collide(type, x, y - 32))
			{
				trace("crate collided with crate, unable to move crate up");
				return false;
			}
			
			y -= 32;
			
			// if I am on a goal, change my state
			OnGoal = (null != collide("goal", x, y));
			
			return true;
		}
		
		public function MoveDown():Boolean
		{
			// if there is a wall below me, we cannot move
			if (collide("wall", x, y + 32))
			{
				trace("crate collided with wall, unable to move crate down");
				return false;
			}
			
			// if there is a crate below me, we cannot move
			if (collide(type, x, y + 32))
			{
				trace("crate collided with crate, unable to move crate down");
				return false;
			}
			
			y += 32;
			
			// if I am on a goal, change my state
			OnGoal = (null != collide("goal", x, y));
			
			return true;
		}
		
		public function MoveLeft():Boolean
		{
			// if there is a wall on my left, we cannot move
			if (collide("wall", x - 32, y))
			{
				trace("crate collided with wall, unable to move crate left");
				return false;
			}
			
			// if there is a crate on my left, we cannot move
			if (collide(type, x - 32, y))
			{
				trace("crate collided with crate, unable to move crate left");
				return false;
			}
			
			x -= 32;
			
			// if I am on a goal, change my state
			OnGoal = (null != collide("goal", x, y));
			
			return true;
		}
		
		public function MoveRight():Boolean
		{
			// if there is a wall on my right, we cannot move
			if (collide("wall", x + 32, y))
			{
				trace("crate collided with wall, unable to move crate right");
				return false;
			}
			
			// if there is a crate on my right, we cannot move
			if (collide(type, x + 32, y))
			{
				trace("crate collided with crate, unable to move crate right");
				return false;
			}
			
			x += 32;
			
			// if I am on a goal, change my state
			OnGoal = (null != collide("goal", x, y));
			
			return true;
		}
	}
}