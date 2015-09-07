package gameplay.WeaponSystem 
{
	/**
	 * ...
	 * @author kaleidos
	 */
	public class WeaponAmmoPackage 
	{
		
		private var _ammoPackage:Object = null;
		public function WeaponAmmoPackage() 
		{
			_ammoPackage = new Object();
			
			for ( var weaponIndex:uint = WeaponTypeDefine.WEAPON_TYPE_MACHINE_GUN; weaponIndex < WeaponTypeDefine.WEAPON_TYPE_MAX; weaponIndex++ )
			{
				_ammoPackage[weaponIndex] = 0;
			}
		}
		public function increaseWeaponAmmo( weaponTyp:uint, ammoValue:uint ):void
		{
			if ( _ammoPackage[weaponTyp] != null )
			{
				_ammoPackage[weaponTyp] = _ammoPackage[weaponTyp] + ammoValue;
			}
			else
			{
				//todo 记log
			}
		}
		public function decreaseWeaponAmmo( weaponTyp:uint, ammoValue:uint ):void
		{
			if ( _ammoPackage[weaponTyp] != null )
			{
				_ammoPackage[weaponTyp] = _ammoPackage[weaponTyp] - ammoValue;
			}
			else
			{
				//todo 记log
			}
		}
		public function hasEnoughAmmo( weaponTyp:uint ):Boolean
		{
			var res:Boolean = false;
			if ( _ammoPackage[weaponTyp] != null )
			{
				res = _ammoPackage[weaponTyp] > 0;
			}
			else
			{
				//todo 记log
			}
			return res;
		}
	}

}