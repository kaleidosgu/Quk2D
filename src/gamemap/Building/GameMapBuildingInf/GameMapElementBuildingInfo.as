package gamemap.Building.GameMapBuildingInf 
{
	import flash.net.registerClassAlias;
	import gamemap.GameMapElementInfo;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GameMapElementBuildingInfo extends GameMapElementInfo 
	{
		
		public function GameMapElementBuildingInfo() 
		{
			super();
		}
		
		override protected function registeClassName():void
		{
			super.registeClassName();
			registerClassAlias("Building.GameMapBuildingInfo.GameMapElementBuildingInfo", GameMapElementBuildingInfo);
		}
	}

}