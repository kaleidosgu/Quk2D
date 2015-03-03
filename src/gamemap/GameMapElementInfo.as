package gamemap 
{
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GameMapElementInfo 
	{

		private var _posX:Number = 0;
		private var _posY:Number = 0;
		private var _elementType:uint = 0;
		
		private var _gridColumn:int = -1;
		private var _gridRow:int = -1;
		public function GameMapElementInfo() 
		{
			
		}
		
		public function get posX():Number 
		{
			return _posX;
		}
		
		public function set posX(value:Number):void 
		{
			_posX = value;
		}
		
		public function get posY():Number 
		{
			return _posY;
		}
		
		public function set posY(value:Number):void 
		{
			_posY = value;
		}
		
		public function get elementType():uint 
		{
			return _elementType;
		}
		
		public function set elementType(value:uint):void 
		{
			_elementType = value;
		}
		
		public function get gridColumn():int 
		{
			return _gridColumn;
		}
		
		public function set gridColumn(value:int):void 
		{
			_gridColumn = value;
		}
		
		public function get gridRow():int 
		{
			return _gridRow;
		}
		
		public function set gridRow(value:int):void 
		{
			_gridRow = value;
		}
		
	}

}