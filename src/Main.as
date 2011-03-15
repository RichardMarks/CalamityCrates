package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;

	/**
	 * ...
	 * @author Richard Marks
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Engine 
	{
		public function Main():void 
		{
			super(800, 600);
		}
		override public function init():void 
		{
			//FP.screen.scale = 2;
			//FP.console.enable();
			FP.world = new GameWorld;
			super.init();
			FP.screen.color = 0xFF000000;
		}
	}
}