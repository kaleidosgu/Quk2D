package gamemap.Building 
{
	import gamemap.GameMapBuildingTyp;
	import org.flixel.FlxObject;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BuildingGravityMachine extends BaseBuildingObject 
	{
		[Embed(source = '../../../res/images/gravityMachine.png')]
		private static var gravityMachine:Class;
		public function BuildingGravityMachine() 
		{
			super();
		}
		override public function resClass():Class
		{
			return gravityMachine;
		}
		override public function getSubTyp():uint
		{
			return GameMapBuildingTyp.GameMapBuildingTyp_GravityMachine;
		}
		public function getGravityValue():int
		{
			return 300;
		}
		override public function collideTrig( flxObj1:FlxObject, flxObj2:FlxObject ):void
		{
			super.collideTrig( flxObj1, flxObj2 );
			if ( flxObj2 is BuildingGravityMachine )
			{
				var gravityObj:BuildingGravityMachine = flxObj2 as BuildingGravityMachine ;
				flxObj1.velocity.y -= gravityObj.getGravityValue();
			}
		}
	}

}