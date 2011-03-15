package  
{
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class GameWorld extends World 
	{
		static private var firstRun:Boolean = true;
		static public function set FirstRun(value:Boolean):void { firstRun = value; }
		public function GameWorld() {}
		override public function begin():void 
		{
			if (firstRun)
			{
				Level.ID = 1;
			}
			
			Moves.Clear();
			
			super.begin();
		}
		
		override public function update():void 
		{
			if (Input.pressed(Key.F))
			{
				if (Level.ID != Level.Count)
				{
					Level.ID = (Level.ID + 1);
				}
			}
			
			if (Input.pressed(Key.R))
			{
				Level.ID = (Level.ID + 0);
			}
			
			if (Input.pressed(Key.U))
			{
				Moves.UndoLastMove();
			}
			
			super.update();
		}
	}
}