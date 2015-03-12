package gamemap.Building 
{
	import org.flixel.FlxGroup;
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
	}

}