package Base 
{
	import gamemap.GameMapBuildingXmlTag;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import util.UtilXmlConvertVariables;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BaseGameObject extends FlxSprite 
	{
		protected var _tileWidth:Number = 8;
		protected var _tileHeight:Number = 8;
		private var _mapCol:uint = 0;
		private var _mapRow:uint = 0;
		public function BaseGameObject( ) 
		{
			super();
		}	
		public function setWorldDataByXml( mapDetailXml:XML ):void
		{
			_mapCol = UtilXmlConvertVariables.convertToUint( mapDetailXml, GameObjectXmlTag.GameObjectXmlTag_mapCol );
			_mapRow = UtilXmlConvertVariables.convertToUint( mapDetailXml, GameObjectXmlTag.GameObjectXmlTag_mapRow );
			setWorldData( _mapCol, _mapRow );
		}
		
		public function setWorldData( mapColOut:uint, mapRowOut:uint ):void
		{
			_mapCol = mapColOut;
			_mapRow = mapRowOut;
			this.x = mapCol * _tileWidth * this.scale.x;
			this.y = mapRow * _tileHeight * this.scale.y;
		}
		
		public function createObjectByXml( mapDetailXml:XML ):void
		{
			var scaleX:Number = UtilXmlConvertVariables.convertToNumber( mapDetailXml, GameObjectXmlTag.GameObjectXmlTag_ScaleX );
			var scaleY:Number = UtilXmlConvertVariables.convertToNumber( mapDetailXml, GameObjectXmlTag.GameObjectXmlTag_ScaleY );
			
			var spriteWidth:Number = UtilXmlConvertVariables.convertToNumber( mapDetailXml, GameMapBuildingXmlTag.BuildingXmlTag_SpriteWidth );
			var spriteHeight:Number = UtilXmlConvertVariables.convertToNumber( mapDetailXml, GameMapBuildingXmlTag.BuildingXmlTag_SpriteHeight );
			
			var spriteCol:uint = UtilXmlConvertVariables.convertToUint( mapDetailXml, GameMapBuildingXmlTag.BuildingXmlTag_SpriteColumn );
			var spriteRows:uint = UtilXmlConvertVariables.convertToUint( mapDetailXml, GameMapBuildingXmlTag.BuildingXmlTag_SpriteRows );
			var spriteLineCnts:uint = UtilXmlConvertVariables.convertToUint( mapDetailXml, GameMapBuildingXmlTag.BuildingXmlTag_SpriteLineCnts );
			
			createObjectByParam( scaleX, scaleY, spriteWidth, spriteHeight, spriteCol, spriteRows, spriteLineCnts );
		}
		public function createObjectByParam( 	scaleX:Number, scaleY:Number,
										spriteWidth:Number, spriteHeight:Number,
										spriteCol:uint, spriteRows:uint,
										spriteCnts:uint ):void
		{
			this.scale.x = scaleX;
			this.scale.y = scaleY;
			_scaleTile( this.scale );
			loadGraphic( resClass(), true, true, spriteWidth, spriteHeight );
			frame = spriteRows * spriteCnts + spriteCol ;
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
		
		protected function _scaleTile( _scaleFact:FlxPoint ):void
		{
			width = _tileWidth * _scaleFact.x;
			height = _tileHeight * _scaleFact.y;
			offset.x -= _tileWidth * ( _scaleFact.x - 1 ) / 2; 
			offset.y -= _tileHeight * ( _scaleFact.y - 1 ) / 2;
		}	
		public function resClass():Class
		{
			return null;
		}
		
		public function getMainTyp():uint
		{
			return 0;
		}
		public function getSubTyp():uint
		{
			return 0;
		}
	}

}