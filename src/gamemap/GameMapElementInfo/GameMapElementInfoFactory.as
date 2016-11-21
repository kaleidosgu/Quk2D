package gamemap.GameMapElementInfo 
{
	import gamemap.Building.GameMapBuildingInf.BuildingInfoGravityMachine;
	import gamemap.Building.GameMapBuildingInf.BuildingInfoDoor;
	import gamemap.Building.GameMapBuildingInf.GameMapElementBuildingInfo;
	import gamemap.GameMapBuildingTyp;
	import gamemap.GameObjectMainTyp;
	import gameutil.BaseClassFactory;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GameMapElementInfoFactory extends BaseClassFactory
	{
		
		public function GameMapElementInfoFactory() 
		{
			AddClass(GameObjectMainTyp.GameObjectMainTyp_Building, GameMapBuildingTyp.GameMapBuildingTyp_GravityMachine, BuildingInfoGravityMachine);
			AddClass(GameObjectMainTyp.GameObjectMainTyp_Building, GameMapBuildingTyp.GameMapBuildingTyp_Door, BuildingInfoDoor);
			AddClass(GameObjectMainTyp.GameObjectMainTyp_Building, GameMapBuildingTyp.GameMapBuildingTyp_Wall, GameMapElementBuildingInfo);
			AddClass(GameObjectMainTyp.GameObjectMainTyp_Building, GameMapBuildingTyp.GameMapBuildingTyp_Teleport, GameMapElementBuildingInfo);
			AddClass(GameObjectMainTyp.GameObjectMainTyp_Building, GameMapBuildingTyp.GameMapBuildingTyp_Elevator, GameMapElementBuildingInfo);
			SetBaseClass(GameMapElementBuildingInfo);
		}
		public function CreateObject( mainTyp:uint, subTyp:uint ):GameMapElementBuildingInfo
		{
			var obj:Object = CreateClassByTyp(mainTyp, subTyp);
			var retObj:GameMapElementBuildingInfo = null;
			if ( obj != null )
			{
				retObj = obj as GameMapElementBuildingInfo;
			}
			return retObj;
		}
	}

}