package gamemap 
{
	import Base.BaseGameObject;
	import Base.GameBaseDataObject;
	import gamemap.Building.BaseBuildingObject;
	import gamemap.Building.BuildingGravityMachine;
	import gamemap.Building.BuildingWall;
	import util.UtilXmlConvertVariables;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GameBuildingFactory 
	{
		
		private var objFunctionFactionXml:Object = new Object();
		private var objFunctionFaction:Object = new Object();
		private var objBuildingXml:Object = new Object();
		
		private var objBuildingClass:Object = new Object();
		public function GameBuildingFactory() 
		{
			objFunctionFactionXml[GameMapBuildingTyp.GameMapBuildingTyp_Wall] = CreateWallXml;
			objFunctionFaction[GameMapBuildingTyp.GameMapBuildingTyp_Wall] = CreateWall;
			
			objBuildingClass[GameMapBuildingTyp.GameMapBuildingTyp_Wall] = BuildingWall;
			objBuildingClass[GameMapBuildingTyp.GameMapBuildingTyp_GravityMachine] = BuildingGravityMachine;
			//objBuildingClass[GameMapBuildingTyp.GameMapBuildingTyp_Wall] = BuildingWall;
		}
		public function CreateTeleport():void
		{
			
		}
		
		public function CreateSpine():void
		{
			
		}
		public function CreateElevator():void
		{
			
		}
		public function CreateLava():void
		{
			
		}
		public function CreateWater():void
		{
			
		}
		public function CreateBuildingByType( buildingTyp:int ):BaseBuildingObject
		{
			var baseBuildingObj:BaseBuildingObject = null;
			var buildingClass:Class = objBuildingClass[buildingTyp];
			if ( buildingClass != null )
			{
				baseBuildingObj = new buildingClass();
			}
			return baseBuildingObj;
		}
		public function CreateWall():BuildingWall
		{
			var newWall:BuildingWall = new BuildingWall();
			return newWall;
		}
		public function CreateGravityMachine():BuildingGravityMachine
		{
			var newMachine:BuildingGravityMachine = new BuildingGravityMachine();
			return newMachine;
		}
		public function CreateWallXml( mapDetailXml:XML ):BuildingWall
		{
			var objXml:XML = objBuildingXml[GameMapBuildingTyp.GameMapBuildingTyp_Wall];
			if ( objXml == null )
			{
				objBuildingXml[GameMapBuildingTyp.GameMapBuildingTyp_Wall] = mapDetailXml;
			}
			var newWall:BuildingWall = new BuildingWall();
			newWall.createObjectByXml( mapDetailXml );
			newWall.setWorldDataByXml( mapDetailXml );
			return newWall;
		}
		public function CreateWallTemplate():BuildingWall
		{
			var newWall:BuildingWall = null;
			var objXml:XML = objBuildingXml[GameMapBuildingTyp.GameMapBuildingTyp_Wall];
			if ( objXml == null )
			{
				trace("CreateWallTemplate error");
			}
			else
			{
				newWall = new BuildingWall();
			}
			return newWall;
		}
		public function CreateDoor():void
		{
			
		}
		public function CreatTrigger():void
		{
			
		}
		public function createBuild( gameData:GameBaseDataObject ):BaseGameObject
		{
			return null;
		}
		public function CreateBuildingByXml( mapDetailXml:XML ):BaseGameObject
		{
			var buildingType:uint = UtilXmlConvertVariables.convertToUint( mapDetailXml, GameMapBuildingXmlTag.BuildingXmlTag_MapType );
			var func:Function = objFunctionFactionXml[buildingType];
				
			var bseObj:BaseGameObject = null;
			if ( func == null )
			{
				trace("func is null");
			}
			else
			{
				bseObj = func( mapDetailXml );
			}
			return bseObj;
		}
	}

}