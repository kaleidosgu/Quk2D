package Base 
{
	import flash.utils.ByteArray;
	import flash.utils.CompressionAlgorithm;
	import flash.net.registerClassAlias;
	/**
	 * 可以让数据Bytearray序列化
	 * @author kaleidos
	 */
	public class GameBaseDataObject extends Object 
	{
		protected var _elementMainType:uint = 0;
		protected var _elementSubType:uint = 0;
		protected var _posX:Number = 0;
		protected var _posY:Number = 0;
		protected var _mapCol:uint = 0;
		protected var _mapRow:uint = 0;
		protected var _scaleX:Number = 0;
		protected var _scaleY:Number = 0;
		protected var _canCollide:Boolean = false;
		
		protected var _spriteWidth:Number = 0;
		protected var _spriteHeight:Number = 0;
		protected var _spriteCol:uint = 0;
		protected var _spriteRows:uint = 0;
		protected var _spriteCnts:uint = 0;
		
		public function GameBaseDataObject() 
		{
			registeClassName();
		}
		
		
		public function cloneData( outInfoData:GameBaseDataObject ):void
		{
			outInfoData.elementMainType = this.elementMainType;
			outInfoData.elementSubType = this.elementSubType;
			outInfoData.posX = this.posX;
			outInfoData.posY = this.posY;
			outInfoData.mapCol = this.mapCol;
			outInfoData.mapRow = this.mapRow;
			outInfoData.scaleX = this.scaleX;
			outInfoData.scaleY = this.scaleY;
			
			outInfoData.spriteWidth = this.spriteWidth;
			outInfoData.spriteHeight = this.spriteHeight;
			outInfoData.spriteCol = this.spriteCol;
			outInfoData.spriteRows = this.spriteRows;
			outInfoData.spriteCnts = this.spriteCnts;
			outInfoData.canCollide	= this.canCollide;
		}
		public function getByteArray():ByteArray
		{
			//registeClassName();
			
			var bytArray:ByteArray = new ByteArray();
			bytArray.writeObject( this );
			bytArray.position = 0;
			bytArray.compress(CompressionAlgorithm.DEFLATE);
			
			return bytArray;
		}
		protected function registeClassName():void
		{
			registerClassAlias("base.GameBaseDataObject", GameBaseDataObject);			
		}
		public function setDataFromByteArray( bytArray:ByteArray ):void
		{
			
		}
		
		public function get mapCol():uint 
		{
			return _mapCol;
		}
		
		public function set mapCol(value:uint):void 
		{
			_mapCol = value;
		}
		
		public function get mapRow():uint 
		{
			return _mapRow;
		}
		
		public function set mapRow(value:uint):void 
		{
			_mapRow = value;
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
		
		public function get spriteWidth():Number 
		{
			return _spriteWidth;
		}
		
		public function set spriteWidth(value:Number):void 
		{
			_spriteWidth = value;
		}
		
		public function get spriteHeight():Number 
		{
			return _spriteHeight;
		}
		
		public function set spriteHeight(value:Number):void 
		{
			_spriteHeight = value;
		}
		
		public function get spriteCol():uint 
		{
			return _spriteCol;
		}
		
		public function set spriteCol(value:uint):void 
		{
			_spriteCol = value;
		}
		
		public function get spriteRows():uint 
		{
			return _spriteRows;
		}
		
		public function set spriteRows(value:uint):void 
		{
			_spriteRows = value;
		}
		
		public function get spriteCnts():uint 
		{
			return _spriteCnts;
		}
		
		public function set spriteCnts(value:uint):void 
		{
			_spriteCnts = value;
		}
		
		public function get scaleX():Number 
		{
			return _scaleX;
		}
		
		public function set scaleX(value:Number):void 
		{
			_scaleX = value;
		}
		
		public function get scaleY():Number 
		{
			return _scaleY;
		}
		
		public function set scaleY(value:Number):void 
		{
			_scaleY = value;
		}
		
		public function get canCollide():Boolean 
		{
			return _canCollide;
		}
		
		public function set canCollide(value:Boolean):void 
		{
			_canCollide = value;
		}
	}

}