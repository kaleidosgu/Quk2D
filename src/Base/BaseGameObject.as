package Base 
{
	import gamemap.GameMapBuildingXmlTag;
	import gamemap.GameMapElementInfo;
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import util.UtilXmlConvertVariables;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BaseGameObject extends FlxSprite 
	{
		protected var _gameObjData:GameBaseDataObject = null;
		private var _selfGroup:FlxGroup	= null;
		public function BaseGameObject( ) 
		{
			super();
			_gameObjData = new GameBaseDataObject();
		}	
		public function collideByOtherObj( otherObj:BaseGameObject ):void
		{
			removeFromGroup();
		}
		public function setWorldDataByXml( mapDetailXml:XML ):void
		{
			setWorldData( 
				UtilXmlConvertVariables.convertToUint( mapDetailXml, GameObjectXmlTag.GameObjectXmlTag_mapCol ),
				UtilXmlConvertVariables.convertToUint( mapDetailXml, GameObjectXmlTag.GameObjectXmlTag_mapRow ) 
				);
		}
		
		public function setWorldData( mapColOut:uint, mapRowOut:uint ):void
		{
			_gameObjData.mapCol = mapColOut;
			_gameObjData.mapRow = mapRowOut;
			this.x = (_gameObjData.mapCol * _gameObjData.spriteWidth * this.scale.x);
			this.y = (_gameObjData.mapRow * _gameObjData.spriteHeight * this.scale.y);
			_gameObjData.posX = x;
			_gameObjData.posY = y;
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
		public function createObjectByBaseData( baseData:GameBaseDataObject ):void
		{
			createObjectByParam( baseData.scaleX, baseData.scaleY, baseData.spriteWidth, baseData.spriteHeight,
			baseData.spriteCol, baseData.spriteRows,
			baseData.spriteCnts );
			setWorldData( baseData.mapCol, baseData.mapRow );
		}
		public function createObjectByParam( 	scaleX:Number, scaleY:Number,
										spriteWidth:Number, spriteHeight:Number,
										spriteCol:uint, spriteRows:uint,
										spriteCnts:uint ):void
		{
			this.scale.x = scaleX;
			this.scale.y = scaleY;
			_gameObjData.scaleX = scaleX;
			_gameObjData.scaleY = scaleY;
			loadGraphic( resClass(), true, true, spriteWidth, spriteHeight );
			_gameObjData.spriteRows = spriteRows;
			_gameObjData.spriteCol 	= spriteCol;
			_gameObjData.spriteCnts	= spriteCnts;
			_gameObjData.spriteWidth = spriteWidth;
			_gameObjData.spriteHeight = spriteHeight;
			_scaleTile( this.scale );
			frame = spriteRows * spriteCnts + spriteCol ;
		}
		protected function _scaleTile( _scaleFact:FlxPoint ):void
		{
			width = _gameObjData.spriteWidth * _scaleFact.x;
			height = _gameObjData.spriteHeight * _scaleFact.y;
			offset.x -= _gameObjData.spriteWidth * ( _scaleFact.x - 1 ) / 2; 
			offset.y -= _gameObjData.spriteHeight * ( _scaleFact.y - 1 ) / 2;
		}	
		public function resClass():Class
		{
			return null;
		}
		
		public function getMainTyp():uint
		{
			return _gameObjData.elementMainType;
		}
		public function getSubTyp():uint
		{
			return _gameObjData.elementSubType;
		}
		
		public function get gameObjData():GameBaseDataObject 
		{
			return _gameObjData;
		}
		
		public function set gameObjData(value:GameBaseDataObject):void 
		{
			_gameObjData = value;
		}
		
		public function setSelfGroup(value:FlxGroup):void 
		{
			_selfGroup = value;
			value.add( this );
		}
		override public function update():void
		{
			super.update();
		}
		public function collideTrig( flxObj1:FlxObject, flxObj2:FlxObject ):void
		{
			
		}
		
		protected function removeFromGroup():void
		{
			if ( _selfGroup != null )
			{
				_selfGroup.remove( this );
			}
		}
	}

}