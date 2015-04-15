package state 
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class TestState extends FlxState 
	{
		[Embed(source = "../../res/images/dr20126.png")]
		private var BackgroundImageClass:Class;
		[Embed(source = "../../res/images/base2.png")]
		private var base2SpriteClass:Class;
		private var darkness:FlxSprite;
		private var myLight:Light;
		private var background:FlxSprite;
		public function TestState() 
		{
			
		}
		override public function create():void {
		  background = new FlxSprite(0, 0, BackgroundImageClass);
		  
		  darkness = new FlxSprite(0,0);
		  darkness.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
		  darkness.scrollFactor.x = darkness.scrollFactor.y = 0;
		  darkness.blend = "multiply";
		  
	 
		  add(background);
		  add(darkness);
		  myLight = new Light(3, 100, darkness );
		  add( myLight );
		}
		override public function draw():void {
		  super.draw();
		}
		override public function update():void
		{
			super.update();
			myLight.x = FlxG.mouse.x;
			myLight.y = FlxG.mouse.y;
		}
		
	}
	

}