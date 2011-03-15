package  
{
	import net.flashpunk.*;
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class Level 
	{
		static public function get Complete():Boolean
		{
			// if all crates are on a goal, the level is complete
			var crateList:Array = [];
			FP.world.getClass(Crate, crateList);
			for each(var crate:Crate in crateList)
			{
				if (!crate.OnGoal)
				{
					return false; 
				}
			}
			return true;
		}
		
		static private var currentLevelID:int = 0;
		static public function get ID():int { return currentLevelID; }
		static public function set ID(value:int):void
		{
			currentLevelID = value;
			Level.Clear();
			
			var levelData:String = Level.Data;
			
			if (levelData == null)
			{
				throw new Error("unable to locate level " + value + " data");
			}
			const AX:Number = 96;
			const AY:Number = 64;
			var x:Number = 0+AX;
			var y:Number = 0+AY;
			var rows:Array = levelData.split("|");
			for each(var row:String in rows)
			{
				var columns:Array = row.split("");
				x = 0+AX;
				for each(var column:String in columns)
				{
					if (column == "#")
					{
						FP.world.add(new Wall(x, y));
					}
					else if (column == "$")
					{
						FP.world.add(new Crate(x, y));
					}
					else if (column == "@")
					{
						FP.world.add(new Player(x, y));
					}
					else if (column == ".")
					{
						FP.world.add(new Goal(x, y));
					}
					else if (column == "*")
					{
						FP.world.add(new Goal(x, y));
						FP.world.add(new Crate(x, y));
					}
					x += 32;
				}
				y += 32;
			}
			
		}
		
		static public function get Count():int
		{
			return Assets.LEVELS.level.length();
		}
		
		static public function get Data():String
		{
			var id:int = currentLevelID;
			
			for each(var node:XML in Assets.LEVELS.level)
			{
				if (int(node.@id) == id)
				{
					//trace("found level data");
					return String(node);
				}
			}
			//trace("unable to find level data");
			return null;
		}
		
		static public function Clear():void
		{
			// clear current level entities from world
			const trashClasses:Array = [Crate, Wall, Player, Goal];
			var trash:Array = [];
			for each(var c:Class in trashClasses)
			{
				trash.length = 0;
				FP.world.getClass(c, trash);
				if (trash.length > 0) { FP.world.removeList(trash); }
			}
		}
	}
}