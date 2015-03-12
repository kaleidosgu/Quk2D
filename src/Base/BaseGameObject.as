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
		private var _mapGrid:uint = 0;
		public function BaseGameObject( ) 
		{
			super();
		}	
		public function createObject( mapDetailXml:XML ):void
		{
			this.scale.x = UtilXmlConvertVariables.convertToNumber( mapDetailXml, GameObjectXmlTag.GameObjectXmlTag_ScaleX );
			this.scale.y = UtilXmlConvertVariables.convertToNumber( mapDetailXml, GameObjectXmlTag.GameObjectXmlTag_ScaleY );
			
			_mapCol = UtilXmlConvertVariables.convertToUint( mapDetailXml, GameObjectXmlTag.GameObjectXmlTag_mapCol );
			_mapGrid = UtilXmlConvertVariables.convertToUint( mapDetailXml, GameObjectXmlTag.GameObjectXmlTag_mapRow );
			this.x = mapCol * _tileWidth * this.scale.x;
			this.y = mapGrid * _tileHeight * this.scale.y;
			_scaleTile( this.scale );
			
			var spriteWidth:Number = UtilXmlConvertVariables.convertToNumber( mapDetailXml, GameMapBuildingXmlTag.BuildingXmlTag_SpriteWidth );
			var spriteHeight:Number = UtilXmlConvertVariables.convertToNumber( mapDetailXml, GameMapBuildingXmlTag.BuildingXmlTag_SpriteHeight );
			loadGraphic( resClass(), true, true, spriteWidth, spriteHeight );
			
			var spriteCol:uint = UtilXmlConvertVariables.convertToUint( mapDetailXml, GameMapBuildingXmlTag.BuildingXmlTag_SpriteColumn );
			var spriteRows:uint = UtilXmlConvertVariables.convertToUint( mapDetailXml, GameMapBuildingXmlTag.BuildingXmlTag_SpriteRows );
			var spriteLineCnts:uint = UtilXmlConvertVariables.convertToUint( mapDetailXml, GameMapBuildingXmlTag.BuildingXmlTag_SpriteLineCnts );
			frame = spriteRows * spriteLineCnts + spriteCol ;
		}
		public function get mapCol():uint 
		{
			return _mapCol;
		}
		
		public function set mapCol(value:uint):void 
		{
			_mapCol = value;
		}
		
		public function get mapGrid():uint 
		{
			return _mapGrid;
		}
		
		public function set mapGrid(value:uint):void 
		{
			_mapGrid = value;
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
	}

}