package gameutil 
{
	import Base.BaseGameObject;
	import gamemap.GameMapElementInfo;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class UtilConvert 
	{
		
		public function UtilConvert() 
		{
			
		}
		
		public static function convertGameObjToElementInfo( gameObj:BaseGameObject, elementInfo:GameMapElementInfo ):void
		{
			elementInfo.elementMainType 	= gameObj.getMainTyp();
			elementInfo.elementSubType 		= gameObj.getSubTyp();
			elementInfo.posX 				= gameObj.x;
			elementInfo.posY 				= gameObj.y;
			elementInfo.gridRow 			= gameObj.mapRow;
			elementInfo.gridColumn 			= gameObj.mapCol;
		}
		
	}

}