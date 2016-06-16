package gamemap.Building.GameMapBuildingInf
{
	import flash.net.registerClassAlias;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BuildingInfoGravityMachine extends GameMapElementBuildingInfo 
	{
		private var _gravityVelocityX:Number = 0;
		private var _gravityVelocityY:Number = 0;
		public function BuildingInfoGravityMachine() 
		{
			super();
		}
		
		override protected function registeClassName():void
		{
			super.registeClassName();
			registerClassAlias("gamemap.Building.GameMapBuildingInf.BuildingInfoGravityMachine", BuildingInfoGravityMachine);
		}
		
		public function get gravityVelocityX():Number 
		{
			return _gravityVelocityX;
		}
		
		public function set gravityVelocityX(value:Number):void 
		{
			_gravityVelocityX = value;
		}
		
		public function get gravityVelocityY():Number 
		{
			return _gravityVelocityY;
		}
		
		public function set gravityVelocityY(value:Number):void 
		{
			_gravityVelocityY = value;
		}
	}

}