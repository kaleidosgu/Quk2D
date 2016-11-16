package gamemap.Building 
{
	import Base.GameBaseDataObject;
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
	}

}