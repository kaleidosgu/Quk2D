package gamemap 
{
	import Base.GameBaseDataObject;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.CompressionAlgorithm;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GameMapElementInfo extends GameBaseDataObject
	{
		public function GameMapElementInfo() 
		{
			super();
		}
		
		override protected function registeClassName():void
		{
			super.registeClassName();
			registerClassAlias("gamemap.GameMapElementInfo", GameMapElementInfo);
		}
		public function setStaticData(dataFrom:GameMapElementInfo):void
		{			
			scaleX = dataFrom.scaleX;
			scaleY = dataFrom.scaleY;
			spriteWidth = dataFrom.spriteWidth;
			spriteHeight = dataFrom.spriteHeight;
			spriteCol = dataFrom.spriteCol;
			spriteRows = dataFrom.spriteRows;
			spriteCnts = dataFrom.spriteCnts;
			canCollide = dataFrom.canCollide;
		}
	}

}