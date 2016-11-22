package gamemap 
{
	/**
	 * ...
	 * @author kaleidos
	 */
	import Base.BaseGameObject;
	import Base.GameBaseDataObject;
	import UI.Data.EditorPadData;
	import fileprocess.FileByteArrayResourcePath;
	import flash.utils.ByteArray;
	import gamemap.Building.BuildingGravityMachine;
	import gamemap.Building.BuildingWall;
	import gamemap.GameMapBuildingXmlTag;
	import gamemap.GameMapElementInfo;
	import gamemap.GameMapInfo;
	import gamemap.GameObjectFactory;
	import gamemap.GameObjectMainTyp;
	import gamemap.Staticdata.StaticDataLoader;
	import gameutil.UtilConvert;
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxXML;
	import util.EventDispatch.GameDispatchSystem;
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
		private var _playerGroup:FlxGroup = null;
		
		private var _arrayMapElement:Array = new Array();
		
		private var gameMapGroupObject:Object = new Object();
		private var _objBuildingGroupData:Object = new Object();
		private var _objItemGroupData:Object = new Object();
		private var _dspInSystem:GameDispatchSystem = null;
		public function GameMapEditor( _flxState:FlxState,outPlayerGroup:FlxGroup,_dspSystem:GameDispatchSystem  ) 
		{
			_dspInSystem = _dspSystem;
			_playerGroup = outPlayerGroup;
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
					var objMain:Object = _objStaticData[gameInfo.elementMainType];
					if ( objMain == null )
					{
						_objStaticData[gameInfo.elementMainType] = new Object();
					}
					_objStaticData[gameInfo.elementMainType][gameInfo.elementSubType] = gameInfo;
				}
			}
		}
		private function _GetItemStaticData( mainType:uint, subType:uint ):GameMapElementInfo
		{
			var returnInfo:GameMapElementInfo = null;
			returnInfo = _objStaticData[mainType][subType];
			return returnInfo;
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
					var staticInfo:GameMapElementInfo = _GetItemStaticData( mapele.elementMainType, mapele.elementSubType );
					if ( staticInfo != null )
					{
						mapele.canCollide = staticInfo.canCollide;	
					}
					gameObj.createObjectByBaseData( mapele );
					gameObj.changeLayer(0);
					gameObj.dsp = _dspInSystem;
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
		public function removeMapElement( xPos:int, yPos:int, mapLayer:uint ):void
		{
			var colNumber:int = xPos / _showWidth;
			var rowNumber:int = yPos / _showHeight;
			var elementInfo:GameMapElementInfo = _gameMapInfo.removeObj( rowNumber, colNumber,mapLayer );
			if ( elementInfo != null )
			{
				var _buildingGroupRemove:FlxGroup = getGameElementGroup( elementInfo.elementMainType,elementInfo.elementSubType );
				if ( _buildingGroupRemove != null )
				{
					var objIndex:uint = 0;
					for each( var removeObj:BaseGameObject in _arrayMapElement )
					{
						if ( removeObj.gameObjData.mapCol == colNumber 
						&& removeObj.gameObjData.mapRow == rowNumber 
						&& removeObj.gameObjData.mapLayer == mapLayer
						)
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
		public function findMapElement( xPos:int, yPos:int,mapLayer:uint ):BaseGameObject
		{
			var foundElement:BaseGameObject = null;
			
			var colNumber:int = xPos / _showWidth;
			var rowNumber:int = yPos / _showHeight;
			var elementInfo:GameMapElementInfo = _gameMapInfo.removeObj( rowNumber, colNumber,mapLayer );
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
							foundElement = removeObj;
							objIndex++;
							break;
						}
					}
				}
			}
			return foundElement;
		}
		public function updateMap( xPos:int, yPos:int, mainTyp:uint, subType:uint, mapLayer:uint,editorPadData:EditorPadData):void
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
					var obj:GameMapElementInfo = _objStaticData[mainTyp][subType];
					if ( obj )
					{
						var _factData:GameMapElementInfo = _gameMapInfo.createObject(mainTyp, subType);
						_factData.mapCol = colNumber;
						_factData.mapRow = rowNumber;
						_factData.mapLayer = mapLayer;
						_factData.setStaticData(obj);
						//todo 这里静态数据写得不够好
						_createObj.createObjectByBaseData( _factData );
						_createObj.dsp = _dspInSystem;
						_createObj.SetEditorPadData(editorPadData);

						var _buildingGroup:FlxGroup = getGameElementGroup( mainTyp, subType );
						_buildingGroup.add( _createObj );	
						
						updateMapData( _createObj );
						_arrayMapElement.push ( _createObj );
					}
				}
			}
		}
		public function choseItem( xPos:int, yPos:int ):Object
		{
			var colNumber:int = xPos / _showWidth;
			var rowNumber:int = yPos / _showHeight;
			var elementInfo:GameMapElementInfo = _gameMapInfo.getObj( rowNumber, colNumber );
			return elementInfo;
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
		protected function commonCollideFunction( flxObj1:FlxObject, flxObj2:FlxObject ):void
		{
			if ( flxObj2 is BaseGameObject )
			{
				var baseObj:BaseGameObject = flxObj2 as BaseGameObject ;
				baseObj.collideTrig( flxObj1, flxObj2 );
			}
		}
		public function update():void
		{
			//todo
			var wallGroup:FlxGroup = _objBuildingGroupData[GameMapBuildingTyp.GameMapBuildingTyp_Wall];
			var gravityGroup:FlxGroup = _objBuildingGroupData[GameMapBuildingTyp.GameMapBuildingTyp_GravityMachine];
			var teleportGroup:FlxGroup = _objBuildingGroupData[GameMapBuildingTyp.GameMapBuildingTyp_Teleport];
			var elevatorGroup:FlxGroup = _objBuildingGroupData[GameMapBuildingTyp.GameMapBuildingTyp_Elevator];
			var doorGroup:FlxGroup = _objBuildingGroupData[GameMapBuildingTyp.GameMapBuildingTyp_Door];

			FlxG.collide( _playerGroup, wallGroup, commonCollideFunction );	
			FlxG.collide( _playerGroup, gravityGroup, commonCollideFunction );	
			FlxG.collide( _playerGroup, teleportGroup, commonCollideFunction );	
			FlxG.collide( _playerGroup, elevatorGroup, commonCollideFunction );	
			FlxG.collide( _playerGroup, doorGroup, commonCollideFunction );	
		}
		public function getBuildingGroup():Array
		{
			var arrayGroup:Array = new Array();
			for ( var idxGroup:uint = GameMapBuildingTyp.GameMapBuildingTyp_None + 1; idxGroup < GameMapBuildingTyp.GameMapBuildingTyp_Max; idxGroup++ )
			{
				var idxOfGroup:FlxGroup = _objBuildingGroupData[idxGroup];
				if ( idxOfGroup != null )
				{
					arrayGroup.push( idxOfGroup );
				}
			}
			return arrayGroup;
		}
	}

}