package gamemap 
{
	import Base.BaseGameObject;
	import Base.GameBaseDataObject;
	import gamemap.Building.BaseBuildingObject;
	import gamemap.Building.BuildingElevator;
	import gamemap.Building.BuildingDoor;
	import gamemap.Building.BuildingGravityMachine;
	import gamemap.Building.BuildingTeleport;
	import gamemap.Building.BuildingWall;
	import gamemap.GameItem.ItemHealth;
	import util.UtilXmlConvertVariables;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GameObjectFactory 
	{
		private var objBuildingClass:Object = new Object();
		private var objItemClass:Object = new Object();
		
		private var objGameType:Object = new Object();
		public function GameObjectFactory() 
		{
			objBuildingClass[GameMapBuildingTyp.GameMapBuildingTyp_Wall] 			= BuildingWall;
			objBuildingClass[GameMapBuildingTyp.GameMapBuildingTyp_GravityMachine] 	= BuildingGravityMachine;
			objBuildingClass[GameMapBuildingTyp.GameMapBuildingTyp_Teleport] 		= BuildingTeleport;
			objBuildingClass[GameMapBuildingTyp.GameMapBuildingTyp_Elevator] 		= BuildingElevator;
			objBuildingClass[GameMapBuildingTyp.GameMapBuildingTyp_Door] 			= BuildingDoor;
			
			objItemClass[GameMapItemTyp.GameMapItemTyp_Health]						= ItemHealth;
			
			objGameType[GameObjectMainTyp.GameObjectMainTyp_Building] 	= objBuildingClass;
			objGameType[GameObjectMainTyp.GameObjectMainTyp_Item] 		= objItemClass;
		}
		public function CreateGameObjectByType( mainType:int, subType:int ):BaseGameObject
		{
			var baseGameObj:BaseGameObject = null;
			var baseGameClass:Class = null;
			var objClass:Object = objGameType[mainType];
			if ( objClass != null )
			{
				baseGameClass = objClass[subType];	
			}
			
			if ( baseGameClass != null )
			{
				baseGameObj = new baseGameClass();
			}
			return baseGameObj;
		}
	}

}