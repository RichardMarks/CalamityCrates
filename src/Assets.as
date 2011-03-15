package  
{
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Richard Marks
	 */
	public class Assets 
	{
		[Embed(source = '../assets/gfx.png')] static private const GFX_PNG:Class;
		static public const GFX:BitmapData = (new GFX_PNG).bitmapData;
		
		[Embed(source = '../assets/levels.xml', mimeType = "application/octet-stream")] static private const LEVELS_XML:Class;
		static public var LEVELS:XML = new XML(new LEVELS_XML);
		
		[Embed(source = '../assets/gamefont.ttf', fontName = 'gamefont')]
		static public const CLINK_OUTLINED_TTF:Class;
	}
}