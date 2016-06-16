package gamemap.Building 
{
	import gamemap.Building.GameMapBuildingInf.BuildingInfoGravityMachine;
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
			_soundBuildingTrig = "jumppad";
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
		override protected function _buildingCollide(flxObj1:FlxObject, flxObj2:FlxObject):void
		{
			super._buildingCollide(flxObj1, flxObj2);
			if ( flxObj2 is BuildingGravityMachine )
			{
				var gravityObj:BuildingGravityMachine = flxObj2 as BuildingGravityMachine ;
				flxObj1.velocity.y -= gravityObj.getGravityValue();
			}
		}
		override public function update():void
		{
			super.update();
			if ( _gameObjData != null )
			{
				if ( _gameObjData is BuildingInfoGravityMachine )
				{
					var dda:BuildingInfoGravityMachine = _gameObjData as BuildingInfoGravityMachine;
					var dafa:uint = 0;
				}
			}
		}
	}

}