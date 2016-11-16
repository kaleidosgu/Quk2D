package gamemap.Building.GameMapBuildingInf 
{
	import flash.net.registerClassAlias;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BuildingInfoDoor extends GameMapElementBuildingInfo 
	{
		private var _mapLayerSpawn:uint = 0;
		private var _posXSpawn:Number = 0;
		private var _posYSpawn:Number = 0;
		public function BuildingInfoDoor() 
		{
			super();
			
		}
		
		override protected function registeClassName():void
		{
			super.registeClassName();
			registerClassAlias("gamemap.Building.GameMapBuildindgInf.BuildingInfoDoor", BuildingInfoDoor);
		}
		
		public function get mapLayerSpawn():uint 
		{
			return _mapLayerSpawn;
		}
		
		public function set mapLayerSpawn(value:uint):void 
		{
			_mapLayerSpawn = value;
		}
		
		public function get posXSpawn():Number 
		{
			return _posXSpawn;
		}
		
		public function set posXSpawn(value:Number):void 
		{
			_posXSpawn = value;
		}
		
		public function get posYSpawn():Number 
		{
			return _posYSpawn;
		}
		
		public function set posYSpawn(value:Number):void 
		{
			_posYSpawn = value;
		}
		
	}

}