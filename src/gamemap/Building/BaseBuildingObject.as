package gamemap.Building 
{
	import Base.BaseGameObject;
	import gamemap.GameMapBuildingTyp;
	import gamemap.GameObjectMainTyp;
	import util.UtilXmlConvertVariables;
	import gamemap.GameMapBuildingXmlTag;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BaseBuildingObject extends BaseGameObject 
	{
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
	}

}