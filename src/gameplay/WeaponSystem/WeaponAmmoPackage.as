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
		}
		public function increaseWeaponAmmo( weaponTyp:uint, ammoValue:uint ):void
		{
			if ( _ammoPackage[weaponTyp] != null )
			{
				_ammoPackage[weaponTyp] = _ammoPackage[weaponTyp] + ammoValue;
			}
			else
			{
				_ammoPackage[weaponTyp] = ammoValue;
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
		public function hasWeapon( weaponTyp:uint ):Boolean
		{
			var res:Boolean = false;
			if ( _ammoPackage[weaponTyp] != null )
			{
				res = true;
			}
			return res;
		}
	}

}