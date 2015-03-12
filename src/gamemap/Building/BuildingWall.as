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
			/*
			var elementWidth:Number = UtilXmlConvertVariables.convertToUint( mapDetailXml, GameMapBuildingXmlTag.BuildingXmlTag_MapType );
			var elementHeight:Number = UtilXmlConvertVariables.convertToUint( mapDetailXml, GameMapBuildingXmlTag.BuildingXmlTag_MapType );
			loadGraphic( wallBlock, true, true, elementWidth, elementWidth );
			*/
			frame = 3 * 16 ;
		}
		override public function resClass():Class
		{
			return wallBlock;
		}
	}

}