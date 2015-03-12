package gamemap 
{
	/**
	 * ...
	 * @author kaleidos
	 */
	import gamemap.Building.BuildingWall;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxXML;
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
				var wall:FlxSprite = buildingFactory.CreateBuilding( mapDetailXml );
				_flxGroup.add( wall );
			}
			
		}
		public function updateMap( xPos:int, yPos:int, mapElementData:int ):void
		{
			var colNumber:int = xPos / _showWidth;
			var rowNumber:int = yPos / _showHeight;
			
			var build:BuildingWall = buildingFactory.CreateWallTemplate();
			build.setWorldData( colNumber, rowNumber );
			_flxGroup.add( build );
			
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