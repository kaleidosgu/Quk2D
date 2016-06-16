package gamemap.GameMapElementInfo 
{
	import gamemap.Building.GameMapBuildingInf.BuildingInfoGravityMachine;
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
			SetBaseClass(GameMapElementBuildingInfo);
		}
		public function CreateObject( mainTyp:uint, subTyp:uint ):GameMapElementBuildingInfo
		{
			var obj:Object = CreateClassByTyp(mainTyp, subTyp);
			var retObj:GameMapElementBuildingInfo = null;
			if ( obj != null )
			{
				if ( obj is GameMapElementBuildingInfo )
				{
					retObj = obj as GameMapElementBuildingInfo;
				}
			}
			return retObj;
		}
	}

}