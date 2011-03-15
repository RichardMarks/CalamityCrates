package  
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class LevelCompleteWorld extends World 
	{
		static private var snapshot:BitmapData;
		static private const zero:Point = new Point;
		static public function Go():void
		{
			snapshot = FP.buffer.clone();
			FP.world = new LevelCompleteWorld;
		}
		
		public function LevelCompleteWorld() {}
		override public function begin():void 
		{
			FP.buffer.copyPixels(snapshot, snapshot.rect, zero);
			
			Text.font = "gamefont";
			Text.size = 64;
			
			//var msg:Text = new Text("Level " + FP.zeroPad(Level.ID, 3) + " Complete!");
			//msg.color = 0xFF80B7E3;
			
			//addGraphic(msg, -1, int((FP.width - msg.width) * 0.5), int((FP.height - msg.height) * 0.5));
			
			//Write("Level " + FP.zeroPad(Level.ID, 3) + " Complete!", 0xFFFFFF00, (FP.height / 3) * 1, 1.0, 10);
			
			addGraphic(MakeLevelCompleteText(), -5);
			
			Text.size = 34;
			Write("Click to Continue", 0xFFFFFFFF, (FP.height / 4) * 3, 1.0, 10);
			
			super.begin();
		}
		
		private function MakeLevelCompleteText():Graphic
		{
			var m:String = "Level " + FP.zeroPad(Level.ID, 3) + " Complete!";
			var text:FancyText = new FancyText(m);
			text.x = int((FP.width - text.width) * 0.5);
			text.y = FP.height / 3;
			text.color = 0x00FF00;
			text.applyFilter(new GlowFilter(0xFFFFFFFF, 1.0, 6, 6, 2, BitmapFilterQuality.LOW, true, true));
			//text.angle = 10;
			return text;
		}
		
		private function Write(message:String, color:uint = 0xFFFFFFFF, y:Number = 0, alpha:Number = 1.0, angle:Number = 0):void
		{
			var text:Text = new Text(message, 0, y);
			text.color = color;
			text.alpha = alpha;
			text.angle = angle;
			
			var textShadow:Text = new Text(message, 0, y+2);
			textShadow.color = 0xFF000000;
			textShadow.alpha = alpha;
			textShadow.angle = angle;
			
			var textHighlight:Text = new Text(message, 0, y - 1);
			textHighlight.color = 0xFFFFFFFF;
			textHighlight.alpha = alpha;
			textHighlight.angle = angle;
			
			text.x = int((FP.width - text.width) * 0.5);
			textShadow.x = text.x - 2;
			textHighlight.x = text.x + 1;
			
			addGraphic(new Graphiclist(textShadow, textHighlight, text), -1);
		}
		
		override public function update():void 
		{
			if (Input.mousePressed)
			{
				FP.world = new GameWorld;
				if (Level.ID != Level.Count)
				{
					Level.ID = (Level.ID + 1);
				}
			}
			super.update();
		}
		
		override public function render():void 
		{
			//
			super.render();
		}
	}
}