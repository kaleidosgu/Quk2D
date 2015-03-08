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
			var newWall:BuildingWall = new BuildingWall();
			newWall.createObject( mapDetailXml );
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