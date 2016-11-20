package gamemap.Building 
{
	import Base.GameBaseDataObject;
	import gamemap.Building.GameMapBuildingInf.BuildingInfoDoor;
	import gamemap.GameMapBuildingTyp;
	import org.flixel.FlxObject;
	import player.BasePlayerObject;
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
			//solid = false;
			
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
		override protected function _buildingCollide(flxObj1:FlxObject, flxObj2:FlxObject):void
		{
			super._buildingCollide(flxObj1, flxObj2);
			if ( flxObj2 is BuildingDoor )
			{
				var gravityObj:BuildingDoor = flxObj2 as BuildingDoor;
				if ( flxObj1 is BasePlayerObject)
				{
					var playerCollide:BasePlayerObject = flxObj1 as BasePlayerObject;
					playerCollide.playerMapLayer = 1;
				}
			}
		}
	}

}