package gamemap.Building 
{
	import gamemap.GameMapBuildingTyp;
	import org.flixel.FlxObject;
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

		override public function collideTrig( flxObj1:FlxObject, flxObj2:FlxObject ):void
		{
			super.collideTrig( flxObj1, flxObj2 );
			flxObj1.x = 500;
			flxObj1.y = 300;
		}
	}

}