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
		protected var _tileWidth:Number = 0;
		protected var _tileHeight:Number = 0;
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
			_scaleTile( this.scale );
			
			this.x = mapGrid * _tileWidth * this.scale.x;
			this.y = mapCol * _tileHeight * this.scale.y;
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
			offset.x = -(_tileWidth / _scaleFact.x);
			offset.y = -(_tileHeight / _scaleFact.y);
		}	
	}

}