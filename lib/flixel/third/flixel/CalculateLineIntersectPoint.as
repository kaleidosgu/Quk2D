package third.flixel 
{
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author ddda
	 */
	public class CalculateLineIntersectPoint 
	{
		
		var _point:FlxPoint
		public function CalculateLineIntersectPoint() 
		{
			
		}
		static public function GetFlxObjectLineVector( flxObject:FlxObject ):Vector.<FlxLine>
		{
			var vec:Vector.<FlxLine> = new Vector.<FlxLine>;
			
			var flxPoint1:FlxPoint = new FlxPoint();
			flxPoint1.x = flxObject.x;
			flxPoint1.y = flxObject.y;
			
			var flxPoint2:FlxPoint = new FlxPoint();
			flxPoint2.x = flxObject.x + flxObject.width;
			flxPoint2.y = flxObject.y;
			
			var flxPoint3:FlxPoint = new FlxPoint();
			flxPoint3.x = flxObject.x + flxObject.width;
			flxPoint3.y = flxObject.y + flxObject.height;
			
			var flxPoint4:FlxPoint = new FlxPoint();
			flxPoint4.x = flxObject.x;
			flxPoint4.y = flxObject.y + flxObject.height;
			
			
			var flxLineNorth:FlxLine = new FlxLine( flxPoint1, flxPoint2);
			var flxLineEast:FlxLine = new FlxLine( flxPoint2, flxPoint3);
			var flxLineSouth:FlxLine = new FlxLine( flxPoint3, flxPoint4);
			var flxLineWest:FlxLine = new FlxLine( flxPoint4, flxPoint1);
			
			vec.push( flxLineNorth );
			vec.push( flxLineEast );
			vec.push( flxLineSouth );
			vec.push( flxLineWest );
			return vec;
		}
		static public function GetIntersectPointFromFlxObjectByLine( flxObject:FlxObject, startPoint:FlxPoint, endPoint:FlxPoint ):void
		{
			//todo
		}
		static public function GetIntersectPointFromFlxObject( flxObject:FlxObject, startPoint:FlxPoint, endPoint:FlxPoint ):FlxPoint
		{
			var resPoint:FlxPoint = null;
			var vec:Vector.<FlxLine> = GetFlxObjectLineVector( flxObject );
			for each( var it:FlxLine in vec )
			{
				resPoint = GetPointByLine( it.lineStartPoint, it.lineEndPoint, startPoint, endPoint );
				if ( resPoint != null )
				{
					break;
				}
			}
			return resPoint;
		}
		static public function GetPointByLine( startPoint1:FlxPoint, end1Point:FlxPoint, startPoint2:FlxPoint, dstEndPoin2):FlxPoint
		{
			var retPoint:FlxPoint = new FlxPoint();
			
			if (startPoint1.x == end1Point.x)
			{
				if (startPoint2.x == dstEndPoin2.x)
				{
					trace("平行线");
					retPoint = null;
				}
				else
				{
					retPoint.x = startPoint1.x;
					retPoint.y = startPoint2.y+(startPoint1.x-startPoint2.x)/(dstEndPoin2.x-startPoint2.x)*(dstEndPoin2.y-startPoint2.y);
				}
			}
			else if (startPoint2.x == dstEndPoin2.x)
			{
				retPoint.x = startPoint2.x;
				retPoint.y = startPoint1.y+(startPoint2.x-startPoint1.x)/(end1Point.x-startPoint1.x)*(end1Point.y-startPoint1.y);
			}
			else
			{
				var K1:Number = (startPoint1.y-end1Point.y)/(startPoint1.x-end1Point.x);
				var K2:Number = (startPoint2.y-dstEndPoin2.y)/(startPoint2.x-dstEndPoin2.x);
				if (K1 == K2)
				{
					trace("平行线");
					retPoint = null;
				}
				else
				{
					var B1:Number = (startPoint1.x*end1Point.y-startPoint1.y*end1Point.x)/(startPoint1.x-end1Point.x);
					var B2:Number = (startPoint2.x*dstEndPoin2.y-startPoint2.y*dstEndPoin2.x)/(startPoint2.x-dstEndPoin2.x);
					retPoint.x = (B2 - B1) / (K1 - K2);
					retPoint.y = K1 * retPoint.x + B1;
				}
			}
			return retPoint;
		}
	}
}