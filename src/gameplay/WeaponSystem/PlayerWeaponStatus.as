package gameplay.WeaponSystem 
{
	/**
	 * ...
	 * @author kaleidos
	 */
	public class PlayerWeaponStatus 
	{
		private var _currentWeaponType:uint 		= 0;
		private var _currentWeaponList:Object 		= new Object();
		private var _staticWeaponAttribute:Object	= new Object();
		private var _currentChangeCDTime:Number 	= 0;
		private var _currentFireCDTime:Number		= 0;
		public function PlayerWeaponStatus() 
		{
			
		}
		public function hasWeaponHolding( weaponType:uint ):Boolean
		{
			var res:Boolean = false;
			if ( _currentWeaponList[weaponType] != null )
			{
				res = true; 
			}
			return res;
		}
		public function isValidChangetime():Boolean
		{
			return false;
		}
		public function isValidCDTime():Boolean
		{
			return false;
		}
	}

}