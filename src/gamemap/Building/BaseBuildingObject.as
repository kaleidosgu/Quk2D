package gamemap.Building 
{
	import Base.BaseGameObject;
	import gamemap.GameMapBuildingTyp;
	import util.UtilXmlConvertVariables;
	import gamemap.GameMapBuildingXmlTag;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BaseBuildingObject extends BaseGameObject 
	{
		protected var _buildingType:uint = GameMapBuildingTyp.GameMapBuildingTyp_None;
		public function BaseBuildingObject() 
		{
			super();
		}
		override public function createObjectByXml( mapDetailXml:XML ):void
		{
			super.createObjectByXml( mapDetailXml );
			
			_buildingType = UtilXmlConvertVariables.convertToUint( mapDetailXml, GameMapBuildingXmlTag.BuildingXmlTag_MapType );
		}
		public function get buildingType():uint 
		{
			return _buildingType;
		}
		
		public function set buildingType(value:uint):void 
		{
			_buildingType = value;
		}
		
	}

}