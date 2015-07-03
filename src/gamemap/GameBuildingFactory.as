package gamemap 
{
	import Base.BaseGameObject;
	import Base.GameBaseDataObject;
	import gamemap.Building.BaseBuildingObject;
	import gamemap.Building.BuildingElevator;
	import gamemap.Building.BuildingGravityMachine;
	import gamemap.Building.BuildingTeleport;
	import gamemap.Building.BuildingWall;
	import util.UtilXmlConvertVariables;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GameBuildingFactory 
	{
		private var objFunctionFaction:Object = new Object();		
		private var objBuildingClass:Object = new Object();
		public function GameBuildingFactory() 
		{
			objBuildingClass[GameMapBuildingTyp.GameMapBuildingTyp_Wall] = BuildingWall;
			objBuildingClass[GameMapBuildingTyp.GameMapBuildingTyp_GravityMachine] = BuildingGravityMachine;
			objBuildingClass[GameMapBuildingTyp.GameMapBuildingTyp_Teleport] = BuildingTeleport;
			objBuildingClass[GameMapBuildingTyp.GameMapBuildingTyp_Elevator] = BuildingElevator;
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
	}

}