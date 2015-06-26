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
		private var buildingFactory:GameBuildingFactory = new GameBuildingFactory();
		
		private var _gameMapInfo:GameMapInfo = new GameMapInfo();
		
		private var _objStaticData:Object = new Object();
		
		private var _objBuildingGroupData:Object = new Object();
		private var _flxStateIn:FlxState = null;
		private var _playerGroup:FlxGroup = new FlxGroup();
		public function GameMapEditor( _flxState:FlxState ) 
		{
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
		private function getBuildingGroup( buildingTyp:int ):FlxGroup
		{
			var _BuildingGroup:FlxGroup = _objBuildingGroupData[buildingTyp];
			
			if ( _BuildingGroup == null )
			{
				_BuildingGroup = new FlxGroup();
				_objBuildingGroupData[buildingTyp] = _BuildingGroup;
				_flxStateIn.add( _BuildingGroup );
			}
			return _BuildingGroup;
		}
		private function updateMapDataFromMapInfo():void
		{
			var arrayMapElement:Array = _gameMapInfo.getArray();
			for each( var mapele:GameMapElementInfo in arrayMapElement )
			{
				var gameObj:BaseGameObject = null;
				var _BuildingGroup:FlxGroup = null;
				if ( mapele.elementMainType == GameObjectMainTyp.GameObjectMainTyp_Building )
				{
					_BuildingGroup = getBuildingGroup( mapele.elementSubType );
					gameObj = buildingFactory.CreateBuildingByType( mapele.elementSubType );
				}
				if ( gameObj != null )
				{
					gameObj.setSelfGroup( _BuildingGroup );
					gameObj.createObjectByBaseData( mapele );
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
		public function updateMap( xPos:int, yPos:int, mainTyp:uint, subType:uint ):void
		{
			var colNumber:int = xPos / _showWidth;
			var rowNumber:int = yPos / _showHeight;
			if ( mainTyp == GameObjectMainTyp.GameObjectMainTyp_None 
			|| subType == GameMapBuildingTyp.GameMapBuildingTyp_None )
			{
				_gameMapInfo.removeObj( rowNumber, colNumber );
			}
			else
			{
				var _createObj:BaseGameObject = null;
				if ( mainTyp == GameObjectMainTyp.GameObjectMainTyp_Building )
				{
					_createObj = buildingFactory.CreateBuildingByType( subType );	
				}
				
				if ( _createObj )
				{
					var obj:GameMapElementInfo = _objStaticData[subType];
					if ( obj )
					{
						obj.mapCol = colNumber;
						obj.mapRow = rowNumber;
						_createObj.createObjectByBaseData( obj );
						UtilConvert.convertGameObjToElementInfo( _createObj, obj );
						var _buildingGroup:FlxGroup = getBuildingGroup( subType );
						_buildingGroup.add( _createObj );	
						
						updateMapData( _createObj );
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