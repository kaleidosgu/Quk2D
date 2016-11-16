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
		//已经作废了GameObjectSettingDataObject把它给代替
		public function UtilConvert() 
		{
			
		}
		
		public static function convertGameObjToElementInfo( gameObj:BaseGameObject, elementInfo:GameMapElementInfo ):void
		{
			elementInfo.elementMainType 	= gameObj.getMainTyp();
			elementInfo.elementSubType 		= gameObj.getSubTyp();
			elementInfo.posX 				= gameObj.x;
			elementInfo.posY 				= gameObj.y;
			elementInfo.mapRow 				= gameObj.gameObjData.mapRow;
			elementInfo.mapCol				= gameObj.gameObjData.mapCol;
			elementInfo.mapLayer			= gameObj.gameObjData.mapLayer;
			elementInfo.scaleX				= gameObj.gameObjData.scaleX;
			elementInfo.scaleY				= gameObj.gameObjData.scaleY;
			
			elementInfo.spriteWidth 		= gameObj.gameObjData.spriteWidth;
			elementInfo.spriteHeight 		= gameObj.gameObjData.spriteHeight ;
			elementInfo.spriteCol 			= gameObj.gameObjData.spriteCol ;
			elementInfo.spriteRows 			= gameObj.gameObjData.spriteRows ;
			elementInfo.spriteCnts 			= gameObj.gameObjData.spriteCnts ;
		}
		
	}

}