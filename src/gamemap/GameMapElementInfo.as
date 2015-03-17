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
			
		}
		
		override protected function registeClassName():void
		{
			super.registeClassName();
			registerClassAlias("gamemap.GameMapElementInfo", GameMapElementInfo);
		}
		
	}

}