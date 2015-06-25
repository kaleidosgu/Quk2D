package gamemap.Building 
{
	import gamemap.GameMapBuildingTyp;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BuildingTeleport extends BaseBuildingObject 
	{
		
		[Embed(source = '../../../res/images/teleport.png')]
		private static var teleportClass:Class;
		public function BuildingTeleport() 
		{
			super();
		}
		override public function createObjectByXml( mapDetailXml:XML ):void
		{
			super.createObjectByXml( mapDetailXml );
		}
		override public function resClass():Class
		{
			return teleportClass;
		}
		override public function getSubTyp():uint
		{
			return GameMapBuildingTyp.GameMapBuildingTyp_Teleport;
		}
		
	}

}