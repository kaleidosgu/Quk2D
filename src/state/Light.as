package state 
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class Light extends FlxSprite {
		
		[Embed(source = "../../res/images/alt_tiles.png")]
		private var LightImageClass:Class;
 
		private var darkness:FlxSprite;
    
		public function Light(x:Number, y:Number, darkness:FlxSprite):void {
			super(x, y, LightImageClass);

			this.darkness = darkness;
			//this.blend = "screen"
			this.width = 100;
			this.height = 10;
		}
 
		override public function draw():void {
			var screenXY:FlxPoint = getScreenXY();
	 
			/*
			darkness.stamp(this,
						screenXY.x - this.width / 2,
						screenXY.y - this.height / 2);
						*/
			//darkness.stamp( this, this.x, this.y );
			super.draw();
		}
	}

}