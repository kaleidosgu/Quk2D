package gamemap.Building 
{
	import Base.GameBaseDataObject;
	import gamemap.Building.GameMapBuildingInf.BuildingInfoDoor;
	import gamemap.GameMapBuildingTyp;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BuildingDoor extends BaseBuildingObject 
	{
		
		[Embed(source = '../../../res/images/door.png')]
		private static var doorClass:Class;
		public function BuildingDoor() 
		{
			super();
			
		}
		
		override public function GameObjectSettingDataObject( dataObj:GameBaseDataObject):void
		{
			super.GameObjectSettingDataObject(dataObj);
		}
		override public function resClass():Class
		{
			return doorClass;
		}
		override public function getSubTyp():uint
		{
			return GameMapBuildingTyp.GameMapBuildingTyp_Door;
		}
		override public function createObjectByBaseData( baseData:GameBaseDataObject ):void
		{
			super.createObjectByBaseData(baseData);
			if ( baseData is BuildingInfoDoor )
			{
				var buildingDoorInfo:BuildingInfoDoor = baseData as BuildingInfoDoor;
				var da:uint = 0;
			}
		}
	}

}