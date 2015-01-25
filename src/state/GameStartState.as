package state 
{	
	import org.flixel.FlxState;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GameStartState extends FlxState 
	{
		[Embed(source = "../../res/back.png")] private static var pointsChessPic:Class;
		public function GameStartState() 
		{
			
		}

		override public function create():void
		{
			super.create();
			var bgChess:FlxSprite = new FlxSprite( );
			bgChess.loadGraphic( pointsChessPic, true, true, 100, 100 );
			this.add( bgChess );	
		}
		override public function destroy():void
		{
			super.destroy();
		}
	}

}