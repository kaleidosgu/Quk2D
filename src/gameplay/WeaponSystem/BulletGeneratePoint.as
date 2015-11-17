package gameplay.WeaponSystem 
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import util.Math.MathUtilTrigonometric;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BulletGeneratePoint 
	{
		private var _mathTrig:MathUtilTrigonometric = new MathUtilTrigonometric();
		private var _generatePoint:FlxPoint = new FlxPoint();
		private var _posOffset:Number = 5;
		public function BulletGeneratePoint() 
		{
			
		}
		
		public function GeneratePoint( srcRect:FlxRect, mousePoint:FlxPoint ):FlxPoint
		{
			_mathTrig.calculateAngBySize( srcRect.x, srcRect.y, srcRect.width, srcRect.height,
			mousePoint.x, mousePoint.y, 2, 2 );//Setting mouse size equal [2:2]
							
			var sinAng:Number = _mathTrig.sinAng;
			var cosAng:Number = _mathTrig.cosAng;
			
			var widthOffsetDistance:Number = srcRect.width / 2 + _posOffset;
			var heightOffsetDistance:Number = srcRect.height / 2 + _posOffset;
			var diffX:Number = cosAng * widthOffsetDistance;
			var diffY:Number = sinAng * heightOffsetDistance;
			_generatePoint.x 	= diffX + srcRect.x + srcRect.width / 2;
			_generatePoint.y	= diffY + srcRect.y + srcRect.height / 2;
			return _generatePoint;
		}
	}

}