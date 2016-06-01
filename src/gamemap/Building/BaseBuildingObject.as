package gamemap.Building 
{
	import Base.BaseGameObject;
	import gameEvent.sound.PlaySoundEvent;
	import gamemap.GameMapBuildingTyp;
	import gamemap.GameObjectMainTyp;
	import org.flixel.FlxObject;
	import util.UtilXmlConvertVariables;
	import gamemap.GameMapBuildingXmlTag;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BaseBuildingObject extends BaseGameObject 
	{
		protected var _soundBuildingTrig:String = "";
		public function BaseBuildingObject() 
		{
			super();
			immovable = true;
		}
		override public function createObjectByXml( mapDetailXml:XML ):void
		{
			super.createObjectByXml( mapDetailXml );
			
			_gameObjData.elementSubType = UtilXmlConvertVariables.convertToUint( mapDetailXml, GameMapBuildingXmlTag.BuildingXmlTag_MapType );
		}
		override public function getMainTyp():uint
		{
			return GameObjectMainTyp.GameObjectMainTyp_Building;
		}
		override public function collideTrig( flxObj1:FlxObject, flxObj2:FlxObject ):void
		{
			super.collideTrig( flxObj1, flxObj2 );
			_buildingCollide( flxObj1, flxObj2 );
			soundPlay(_soundBuildingTrig);
		}
		protected function _buildingCollide(flxObj1:FlxObject, flxObj2:FlxObject):void
		{
			
		}
		
		protected function soundPlay( strSound:String ):void
		{
			var evt:PlaySoundEvent = new PlaySoundEvent( PlaySoundEvent.PLAY_SOUND_EVENT );
			evt.strSound = strSound;
			dsp.DispatchEvent(evt);
		}
	}

}