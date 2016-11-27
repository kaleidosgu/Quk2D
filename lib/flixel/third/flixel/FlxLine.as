package third.flixel 
{
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author ddda
	 */
	public class FlxLine 
	{

		private var _lineStartPoint:FlxPoint = new FlxPoint();
		private var _lineEndPoint:FlxPoint = new FlxPoint();
		public function FlxLine(startPoint:FlxPoint, endPoint:FlxPoint) 
		{
			_lineStartPoint.x = startPoint.x;
			_lineStartPoint.y = startPoint.y;
			
			_lineEndPoint.x = endPoint.x;
			_lineEndPoint.y = endPoint.y;
		}
		public function get lineStartPoint():FlxPoint
		{
			return _lineStartPoint;
		}
		
		public function get lineEndPoint():FlxPoint
		{
			return _lineEndPoint;
		}
		
	}

}