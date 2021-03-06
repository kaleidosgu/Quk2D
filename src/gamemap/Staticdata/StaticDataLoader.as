package gamemap.Staticdata 
{
	import Base.GameBaseDataObject;
	import Base.GameObjectXmlTag;
	import gamemap.GameMapBuildingXmlTag;
	import gamemap.GameMapElementInfo;
	import util.UtilXmlConvertVariables;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class StaticDataLoader 
	{
		
		public function StaticDataLoader() 
		{
			
		}
		
		public function load( mapDetailXml:XML ):GameMapElementInfo
		{
			var newStaticData:GameMapElementInfo = new GameMapElementInfo();
			var scaleX:Number = UtilXmlConvertVariables.convertToNumber( mapDetailXml, GameObjectXmlTag.GameObjectXmlTag_ScaleX );
			var scaleY:Number = UtilXmlConvertVariables.convertToNumber( mapDetailXml, GameObjectXmlTag.GameObjectXmlTag_ScaleY );
			
			var spriteWidth:Number = UtilXmlConvertVariables.convertToNumber( mapDetailXml, GameMapBuildingXmlTag.BuildingXmlTag_SpriteWidth );
			var spriteHeight:Number = UtilXmlConvertVariables.convertToNumber( mapDetailXml, GameMapBuildingXmlTag.BuildingXmlTag_SpriteHeight );
			
			var spriteCol:uint = UtilXmlConvertVariables.convertToUint( mapDetailXml, GameMapBuildingXmlTag.BuildingXmlTag_SpriteColumn );
			var spriteRows:uint = UtilXmlConvertVariables.convertToUint( mapDetailXml, GameMapBuildingXmlTag.BuildingXmlTag_SpriteRows );
			var spriteLineCnts:uint = UtilXmlConvertVariables.convertToUint( mapDetailXml, GameMapBuildingXmlTag.BuildingXmlTag_SpriteLineCnts );
			var collide:Boolean = UtilXmlConvertVariables.convertToUint( mapDetailXml, GameMapBuildingXmlTag.BuildingXmlTag_Collide ) >= 1;
			
			
			var mainType:uint = UtilXmlConvertVariables.convertToUint( mapDetailXml, GameObjectXmlTag.GameObjectXmlTag_mainType );
			var subType:uint = UtilXmlConvertVariables.convertToUint( mapDetailXml, GameObjectXmlTag.GameObjectXmlTag_subType );
			
			newStaticData.scaleX = scaleX;
			newStaticData.scaleY = scaleY;
			newStaticData.spriteWidth = spriteWidth;
			newStaticData.spriteHeight = spriteHeight;
			newStaticData.spriteCol = spriteCol;
			newStaticData.spriteRows = spriteRows;
			newStaticData.spriteCnts = spriteLineCnts;
			newStaticData.elementMainType = mainType;
			newStaticData.elementSubType = subType;
			newStaticData.canCollide = collide;
			return newStaticData;
		}
		
	}

}