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
		override public function createObject( mapDetailXml:XML ):void
		{
			super.createObject( mapDetailXml );
			
			loadGraphic( wallBlock, true, true, 8, 8 );
			frame = 3 * 16 ;
		}
	}

}