package  
{
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class Moves 
	{
		static private var recordedMoves:Vector.<Object> = new Vector.<Object>();
		
		static public function Clear():void
		{
			recordedMoves.length = 0;
		}
		
		static public function RecordMove(player:Player, direction:uint = 0, crate:Crate = null):void
		{
			// no movement, no recording
			if (direction == 0)
			{
				return;
			}
			
			// record the move data
			recordedMoves.unshift( { target:player, data:direction, pushed:crate } );
		}
		
		static public function UndoLastMove():void
		{
			if (recordedMoves.length == 0)
			{
				return;
			}
			
			var record:Object = recordedMoves.shift();
			
			var player:Player = Player(record.target);
			switch(record.data)
			{
				case 3: { player.MoveLeft(false); } break;
				case 6: { player.MoveUp(false); } break;
				case 9: { player.MoveRight(false); } break;
				case 12: { player.MoveDown(false); } break;
				default:break;
			}
			
			// if there was no crate pushed, we can bail out now
			if (record.pushed == null)
			{
				return;
			}
			
			var crate:Crate = Crate(record.pushed);
			switch(record.data)
			{
				case 3: { crate.MoveLeft(); } break;
				case 6: { crate.MoveUp(); } break;
				case 9: { crate.MoveRight(); } break;
				case 12: { crate.MoveDown(); } break;
				default:break;
			}
		}
	}
}