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
	import gamemap.Building.BuildingGravityMachine;
	import gamemap.Building.BuildingWall;
	import gamemap.Staticdata.StaticDataLoader;
	import gameutil.UtilConvert;
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxXML;
	import util.KalResourceDataRead;
	import util.KalResourceDataWrite;
	public class GameMapEditor 
	{
		
		[Embed(source="../../res/mapdata/mapinfo_static.xml",mimeType="application/octet-stream")]
		protected var embXML:Class;
		
		private var _showWidth:uint = 0;
		private var _showHeight:uint = 0;
		private var _mapData:Array = new Array();
		private var xmlT:FlxXML = new FlxXML();
		private var objectFactory:GameObjectFactory = new GameObjectFactory();
		
		private var _gameMapInfo:GameMapInfo = new GameMapInfo();
		
		private var _objStaticData:Object = new Object();
		
		private var _flxStateIn:FlxState = null;
		private var _playerGroup:FlxGroup = new FlxGroup();
		
		private var _arrayMapElement:Array = new Array();
		
		private var gameMapGroupObject:Object = new Object();
		private var _objBuildingGroupData:Object = new Object();
		private var _objItemGroupData:Object = new Object();
		public function GameMapEditor( _flxState:FlxState ) 
		{
			gameMapGroupObject[GameObjectMainTyp.GameObjectMainTyp_Building] 	= _objBuildingGroupData ;
			gameMapGroupObject[GameObjectMainTyp.GameObjectMainTyp_Item] 		= _objItemGroupData ;
			_flxStateIn = _flxState;
			
			var xmlData:XML = xmlT.loadEmbedded(embXML);
			var mapDetailXmlLst:XMLList = xmlData.child(GameMapBuildingXmlTag.BuildingElementStaticTag);
			var loader:StaticDataLoader = new StaticDataLoader();
			for each ( var mapDetailXml:XML in mapDetailXmlLst )
			{
				var gameInfo:GameMapElementInfo = loader.load( mapDetailXml );	
				if ( gameInfo )
				{
					_objStaticData[gameInfo.elementSubType] = gameInfo;
				}
			}
		}
		public function generateMapDataFromXml():void
		{
			var xmlData:XML = xmlT.loadEmbedded(embXML);
			var mapDetailXmlLst:XMLList = xmlData.child(GameMapBuildingXmlTag.BuildingXmlTag_MapDetail);
			
			for each ( var mapDetailXml:XML in mapDetailXmlLst )
			{
			}
		}
		public function generateMapDataFromByteArray( resFileName:String ):void
		{
			var kagResPath:FileByteArrayResourcePath = new FileByteArrayResourcePath( resFileName );
			var filePathString:String = kagResPath.resourcePath;
			var readFile:KalResourceDataRead = new KalResourceDataRead( filePathString );
			var readedByteArray:ByteArray = new ByteArray();
			
			readFile.readFileIntoByteArray( filePathString, readedByteArray );
			_gameMapInfo.setDataFromByteArray( readedByteArray );
			updateMapDataFromMapInfo();
		}
		private function getGameElementGroup( mainType:int, subType:int ):FlxGroup
		{
			var _GameGroupObj:Object = gameMapGroupObject[mainType];
			var _gameElementGroup:FlxGroup = null;
			if ( _GameGroupObj != null )
			{
				_gameElementGroup = _GameGroupObj[subType];
			
				if ( _gameElementGroup == null )
				{
					_gameElementGroup = new FlxGroup();
					_GameGroupObj[subType] = _gameElementGroup;
					_flxStateIn.add( _gameElementGroup );
				}	
			}
			return _gameElementGroup;
		}
		private function updateMapDataFromMapInfo():void
		{
			var arrayMapElement:Array = _gameMapInfo.getArray();
			for each( var mapele:GameMapElementInfo in arrayMapElement )
			{
				var gameObj:BaseGameObject = null;
				var _elementGroup:FlxGroup = null;
				_elementGroup = getGameElementGroup( mapele.elementMainType, mapele.elementSubType );
				gameObj = objectFactory.CreateGameObjectByType( mapele.elementMainType, mapele.elementSubType );
				if ( gameObj != null )
				{
					gameObj.setSelfGroup( _elementGroup );
					gameObj.createObjectByBaseData( mapele );
					_arrayMapElement.push ( gameObj );
				}
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
		public function removeMapElement( xPos:int, yPos:int ):void
		{
			var colNumber:int = xPos / _showWidth;
			var rowNumber:int = yPos / _showHeight;
			var elementInfo:GameMapElementInfo = _gameMapInfo.removeObj( rowNumber, colNumber );
			if ( elementInfo != null )
			{
				var _buildingGroupRemove:FlxGroup = getGameElementGroup( elementInfo.elementMainType,elementInfo.elementSubType );
				if ( _buildingGroupRemove != null )
				{
					var objIndex:uint = 0;
					for each( var removeObj:BaseGameObject in _arrayMapElement )
					{
						if ( removeObj.gameObjData.mapCol == colNumber &&
						removeObj.gameObjData.mapRow == rowNumber )
						{
							_buildingGroupRemove.remove( removeObj );
							_arrayMapElement.splice( objIndex, 1 );
							objIndex++;
							break;
						}
					}
				}
			}
		}
		public function updateMap( xPos:int, yPos:int, mainTyp:uint, subType:uint ):void
		{
			var colNumber:int = xPos / _showWidth;
			var rowNumber:int = yPos / _showHeight;
			if ( mainTyp != GameObjectMainTyp.GameObjectMainTyp_None 
			&& subType != GameMapBuildingTyp.GameMapBuildingTyp_None )
			{
				var _createObj:BaseGameObject = null;
				_createObj = objectFactory.CreateGameObjectByType( mainTyp, subType );	
				
				if ( _createObj )
				{
					var obj:GameMapElementInfo = _objStaticData[subType];
					if ( obj )
					{
						obj.mapCol = colNumber;
						obj.mapRow = rowNumber;
						_createObj.createObjectByBaseData( obj );
						UtilConvert.convertGameObjToElementInfo( _createObj, obj );
						var _buildingGroup:FlxGroup = getGameElementGroup( mainTyp, subType );
						_buildingGroup.add( _createObj );	
						
						updateMapData( _createObj );
						_arrayMapElement.push ( _createObj );
					}
				}
			}
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
		
		public function addActor( flxobj:FlxObject ):void
		{
			_playerGroup.add( flxobj );
		}

		protected function collideWall( flxObj1:FlxObject, flxObj2:FlxObject ):void
		{
			flxObj1.drag.x = 300;
		}
		protected function collideGravity( flxObj1:FlxObject, flxObj2:FlxObject ):void
		{
			if ( flxObj2 is BuildingGravityMachine )
			{
				var gravityObj:BuildingGravityMachine = flxObj2 as BuildingGravityMachine ;
				flxObj1.velocity.y -= gravityObj.getGravityValue();
			}
		}
		protected function collideTeleport( flxObj1:FlxObject, flxObj2:FlxObject ):void
		{
			flxObj1.x = 500;
			flxObj1.y = 300;
		}
		public function update():void
		{
			//todo
			var wallGroup:FlxGroup = _objBuildingGroupData[GameMapBuildingTyp.GameMapBuildingTyp_Wall];
			var gravityGroup:FlxGroup = _objBuildingGroupData[GameMapBuildingTyp.GameMapBuildingTyp_GravityMachine];
			var teleportGroup:FlxGroup = _objBuildingGroupData[GameMapBuildingTyp.GameMapBuildingTyp_Teleport];
			var elevatorGroup:FlxGroup = _objBuildingGroupData[GameMapBuildingTyp.GameMapBuildingTyp_Elevator];

			FlxG.collide( _playerGroup, wallGroup, collideWall );	
			FlxG.collide( _playerGroup, gravityGroup, collideGravity );	
			FlxG.collide( _playerGroup, teleportGroup, collideTeleport );	
			FlxG.collide( _playerGroup, elevatorGroup, collideElevator );	
		}
		protected function collideElevator( flxObj1:FlxObject, flxObj2:FlxObject ):void
		{
		}
	}

}