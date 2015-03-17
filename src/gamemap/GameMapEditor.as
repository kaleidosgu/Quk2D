package gamemap 
{
	/**
	 * ...
	 * @author kaleidos
	 */
	import Base.BaseGameObject;
	import Base.GameBaseDataObject;
	import fileprocess.FileByteArrayResourcePath;
	import flash.utils.ByteArray;
	import gamemap.Building.BuildingWall;
	import gameutil.UtilConvert;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxXML;
	import util.KalResourceDataRead;
	import util.KalResourceDataWrite;
	public class GameMapEditor 
	{
		
		[Embed(source="../../res/mapdata/mapinfo.xml",mimeType="application/octet-stream")]
		protected var embXML:Class;
		
		private var _showWidth:uint = 0;
		private var _showHeight:uint = 0;
		private var _mapData:Array = new Array();
		private var xmlT:FlxXML = new FlxXML();
		private var buildingFactory:GameBuildingFactory = new GameBuildingFactory();
		
		private var _flxGroup:FlxGroup;
		private var _gameMapInfo:GameMapInfo = new GameMapInfo();
		public function GameMapEditor( flxGroup:FlxGroup ) 
		{
			_flxGroup = flxGroup;
		}
		public function generateMapDataFromXml():void
		{
			var xmlData:XML = xmlT.loadEmbedded(embXML);
			var mapDetailXmlLst:XMLList = xmlData.child(GameMapBuildingXmlTag.BuildingXmlTag_MapDetail);
			
			for each ( var mapDetailXml:XML in mapDetailXmlLst )
			{
				//var wall:BaseGameObject = buildingFactory.CreateBuilding(  );
				//_flxGroup.add( wall );
				
				//updateMapData( wall );
			}
		}
		public function generateMapDataFromByteArray():void
		{
			var kagResPath:FileByteArrayResourcePath = new FileByteArrayResourcePath("test");
			var filePathString:String = kagResPath.resourcePath;
			var readFile:KalResourceDataRead = new KalResourceDataRead( filePathString );
			var readedByteArray:ByteArray = new ByteArray();
			
			readFile.readFileIntoByteArray( filePathString, readedByteArray );
			_gameMapInfo.setDataFromByteArray( readedByteArray );
			updateMapDataFromMapInfo();
		}
		private function updateMapDataFromMapInfo():void
		{
			var arrayMapElement:Array = _gameMapInfo.getArray();
			for each( var mapele:GameMapElementInfo in arrayMapElement )
			{
				var wall:BaseGameObject = buildingFactory.CreateWall();
				wall.createObjectByBaseData( mapele );
				_flxGroup.add( wall );
				
				updateMapData( wall );
			}
		}
		private function updateMapData( gameObj:BaseGameObject ):void
		{
			_gameMapInfo.updateMapData( gameObj );
		}
		public function saveMapIntoFile():void
		{
			var bytarr:ByteArray = _gameMapInfo.getByteArray();
			
			var kagResPath:FileByteArrayResourcePath = new FileByteArrayResourcePath("test");
			var filePathString:String = kagResPath.resourcePath;
			
			var writeFile:KalResourceDataWrite = new KalResourceDataWrite();
			writeFile.writeBytesToFile( filePathString, bytarr );
		}
		public function updateMap( xPos:int, yPos:int, mainTyp:uint, subType:uint ):void
		{
			var colNumber:int = xPos / _showWidth;
			var rowNumber:int = yPos / _showHeight;
			var _createObj:BaseGameObject = null;
			if ( mainTyp == GameObjectMainTyp.GameObjectMainTyp_Building )
			{
				if ( subType == GameMapBuildingTyp.GameMapBuildingTyp_Wall )
				{
					_createObj = buildingFactory.CreateWall( );
				}
			}
			
			if ( _createObj )
			{
				var newElementInfo:GameMapElementInfo = new GameMapElementInfo();
				newElementInfo.scaleX = 2;
				newElementInfo.scaleY = 2;
				newElementInfo.mapCol = colNumber;
				newElementInfo.mapRow = rowNumber;
				newElementInfo.spriteWidth = 8;
				newElementInfo.spriteHeight = 8;
				newElementInfo.spriteCol = 0;
				newElementInfo.spriteRows = 3;
				newElementInfo.spriteCnts = 16;
				_createObj.createObjectByBaseData( newElementInfo );
				UtilConvert.convertGameObjToElementInfo( _createObj, newElementInfo );
				_flxGroup.add( _createObj );	
				
				updateMapData( _createObj );
			}
			
			/*
			
			var updateElement:GameMapElementInfo = null;
			for each ( var element:GameMapElementInfo in _mapData )
			{
				if ( element.gridColumn == colNumber && element.gridRow == rowNumber )
				{
					updateElement = element;
					break;
				}
			}
			if ( updateElement == null )
			{
				updateElement = new GameMapElementInfo();
				updateElement.gridRow = rowNumber;
				updateElement.gridColumn = colNumber;
			}
			updateElement.elementType = mapElementData;
			*/
		}
		
		public function get showWidth():uint 
		{
			return _showWidth;
		}
		
		public function set showWidth(value:uint):void 
		{
			_showWidth = value;
		}
		
		public function get showHeight():uint 
		{
			return _showHeight;
		}
		
		public function set showHeight(value:uint):void 
		{
			_showHeight = value;
		}
	}

}