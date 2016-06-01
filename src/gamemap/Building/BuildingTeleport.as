package gamemap.Building 
{
	import gameEvent.sound.PlaySoundEvent;
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
		private var _objTrig:FlxObject = null;
		public function BuildingTeleport() 
		{
			super();
			_soundBuildingTrig = "telein";
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

		override protected function _buildingCollide(flxObj1:FlxObject, flxObj2:FlxObject):void
		{
			super._buildingCollide(flxObj1, flxObj2);
			_enableUpdateTick = true;
			tickConstCount = 0.5;
			_objTrig = flxObj1;
			_objTrig.visible = false;
			_objTrig.moves = false;
			_objTrig.x = 500;
			_objTrig.y = 300;
		}
		
		override protected function TickUpdateFunction():void
		{
			if ( _objTrig != null )
			{
				_objTrig.visible = true;
				_enableUpdateTick = false;
				_objTrig.moves = true;
				soundPlay("teleout");
			}
		}
	}

}