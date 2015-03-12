package gamemap 
{
	import Base.BaseGameObject;
	import gamemap.Building.BuildingWall;
	import util.UtilXmlConvertVariables;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GameBuildingFactory 
	{
		
		private var objFunctionFaction:Object = new Object();
		private var objBuildingXml:Object = new Object();
		public function GameBuildingFactory() 
		{
			objFunctionFaction[GameMapBuildingTyp.GameMapBuildingTyp_Wall] = CreateWall;
		}
		public function CreateGravityMachine():void
		{
			
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
		public function CreateWall( mapDetailXml:XML ):BuildingWall
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
				newWall.createObjectByXml( objXml );
			}
			return newWall;
		}
		public function CreateDoor():void
		{
			
		}
		public function CreatTrigger():void
		{
			
		}
		
		public function CreateBuilding( mapDetailXml:XML ):BaseGameObject
		{
			var buildingType:uint = UtilXmlConvertVariables.convertToUint( mapDetailXml, GameMapBuildingXmlTag.BuildingXmlTag_MapType );
			var func:Function = objFunctionFaction[buildingType];
			
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