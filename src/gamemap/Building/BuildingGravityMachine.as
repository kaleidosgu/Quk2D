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
		
		override protected function actorCollided( flxObj1:FlxObject, flxObj2:FlxObject ):void
		{
			super.actorCollided ( flxObj1, flxObj2 );
			//flxObj1.velocity.y -= 300;
		}
	}

}