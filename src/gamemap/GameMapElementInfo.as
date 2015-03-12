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
		private var _elementMainType:uint = 0;
		private var _elementSubType:uint = 0;
		
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
		
		public function get elementMainType():uint 
		{
			return _elementMainType;
		}
		
		public function set elementMainType(value:uint):void 
		{
			_elementMainType = value;
		}
		
		public function get elementSubType():uint 
		{
			return _elementSubType;
		}
		
		public function set elementSubType(value:uint):void 
		{
			_elementSubType = value;
		}
		
	}

}