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
		override protected function actorCollided( flxObj1:FlxObject, flxObj2:FlxObject ):void
		{
			super.actorCollided ( flxObj1, flxObj2 );
			//flxObj1.drag.x = 300;
		}
	}

}