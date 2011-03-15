package  
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class Player extends Entity 
	{
		static private var playerImage:Image;
		
		private var steps:int = 0;
		private var levelCompleted:Boolean = false;
		
		public function Player(xPos:Number = 0, yPos:Number = 0) 
		{
			if (playerImage == null)
			{
				playerImage = new Image(Assets.GFX, new Rectangle(32 * 4, 0, 32, 32));
			}
			layer = 0;
			type = "player";
			graphic = playerImage;
			
			var px:int = int(xPos / 32);
			var py:int = int(yPos / 32);
			
			x = px * 32;
			y = py * 32;
			
			steps = 0;
			
			setHitbox(playerImage.width, playerImage.height);
			
			levelCompleted = false;
		}
		
		override public function update():void 
		{
			if (levelCompleted)
			{
				trace("completed level", Level.ID + "/" + Level.Count, "in", steps, (steps == 1)?"step":"steps");
				LevelCompleteWorld.Go();
				super.update();
				return;
			}
			
			if (Input.pressed(Key.UP)) { MoveUp(); CheckComplete(); }
			else if (Input.pressed(Key.DOWN)) { MoveDown(); CheckComplete(); }
			if (Input.pressed(Key.LEFT)) { MoveLeft(); CheckComplete(); }
			else if (Input.pressed(Key.RIGHT)) { MoveRight(); CheckComplete(); }
			
			super.update();
		}
		
		private function CheckComplete():void
		{
			if (Level.Complete)
			{
				levelCompleted = true;
			}
		}
		
		public function MoveUp(record:Boolean = true):void
		{
			// if there is a wall above me, we cannot move
			if (collide("wall", x, y - 32))
			{
				trace("player collided with wall, unable to move north");
				return;
			}
			
			// if there is a crate above me
			var crate:Crate = Crate(collide("crate", x, y - 32));
			if (crate)
			{
				trace("player collided with crate, attempting to push crate");
				if (crate.MoveUp())
				{
					trace("crate moved, player advancing to the north");
					y -= 32;
					steps++;
					if (record) { Moves.RecordMove(this, 12, crate); }
				}
				return;
			}
			trace("player advancing to the north");
			y -= 32;
			steps++;
			if (record) { Moves.RecordMove(this, 12); }
		}
		
		public function MoveDown(record:Boolean = true):void
		{
			// if there is a wall below me, we cannot move
			if (collide("wall", x, y + 32))
			{
				trace("player collided with wall, unable to move south");
				return;
			}
			
			// if there is a crate below me
			var crate:Crate = Crate(collide("crate", x, y + 32));
			if (crate)
			{
				trace("player collided with crate, attempting to push crate");
				if (crate.MoveDown())
				{
					trace("crate moved, player advancing to the south");
					y += 32;
					steps++;
					if (record) { Moves.RecordMove(this, 6, crate); }
				}
				return;
			}
			trace("player advancing to the south");
			y += 32;
			steps++;
			if (record) { Moves.RecordMove(this, 6); }
		}
		
		public function MoveLeft(record:Boolean = true):void
		{
			// if there is a wall to my left, we cannot move
			if (collide("wall", x - 32, y))
			{
				trace("player collided with wall, unable to move left");
				return;
			}
			
			// if there is a crate to my left
			var crate:Crate = Crate(collide("crate", x - 32, y));
			if (crate)
			{
				trace("player collided with crate, attempting to push crate");
				if (crate.MoveLeft())
				{
					trace("crate moved, player advancing to the left");
					x -= 32;
					steps++;
					if (record) { Moves.RecordMove(this, 9, crate); }
				}
				return;
			}
			trace("player advancing to the left");
			x -= 32;
			steps++;
			if (record) { Moves.RecordMove(this, 9); }
		}
		
		public function MoveRight(record:Boolean = true):void
		{
			// if there is a wall to my right, we cannot move
			if (collide("wall", x + 32, y))
			{
				trace("player collided with wall, unable to move right");
				return;
			}
			
			// if there is a crate to my right
			var crate:Crate = Crate(collide("crate", x + 32, y));
			if (crate)
			{
				trace("player collided with crate, attempting to push crate");
				if (crate.MoveRight())
				{
					trace("crate moved, player advancing to the right");
					x += 32;
					steps++;
					if (record) { Moves.RecordMove(this, 3, crate); }
				}
				return;
			}
			trace("player advancing to the right");
			x += 32;
			steps++;
			if (record) { Moves.RecordMove(this, 3); }
		}
		
	}
}