package gamemap.Building 
{
	import gamemap.GameMapBuildingTyp;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BuildingWall extends BaseBuildingObject 
	{
		
		[Embed(source = '../../../res/images/world.png')]
		private static var wallBlock:Class;
		public function BuildingWall() 
		{
			super();
		}
		override public function createObjectByXml( mapDetailXml:XML ):void
		{
			super.createObjectByXml( mapDetailXml );
		}
		override public function resClass():Class
		{
			return wallBlock;
		}
		override public function getSubTyp():uint
		{
			return GameMapBuildingTyp.GameMapBuildingTyp_Wall;
		}
	}

}