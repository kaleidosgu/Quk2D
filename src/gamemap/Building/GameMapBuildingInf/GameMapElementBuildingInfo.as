package gamemap.Building.GameMapBuildingInf 
{
	import flash.net.registerClassAlias;
	import gamemap.GameMapElementInfo;
	import flash.utils.getQualifiedClassName;
	
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
			registerClassAlias("gamemap.Building.GameMapBuildingInf.GameMapElementBuildingInfo", GameMapElementBuildingInfo);
		}
	}

}