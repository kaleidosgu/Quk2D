package gameplay.WeaponSystem 
{
	/**
	 * ...
	 * @author kaleidos
	 */
	public class PlayerWeaponStatus 
	{
		private var _currentWeaponList:Object 		= new Object();
		private var _currentChangeCDTime:Number 	= 0;
		private var _currentFireCDTime:Number		= 0;
		
		private var _weaponLoader:WeaponAttributeLoadFromXml = null;
		private var _dictWeaponAttr:Object = new Object();
		private var _currentWeaponAttr:WeaponAttribute = null;
		
		private var _ammoPackage:WeaponAmmoPackage = null;
		public function PlayerWeaponStatus() 
		{
			_weaponLoader = new WeaponAttributeLoadFromXml();
			_weaponLoader.loadDataFromXml( _dictWeaponAttr );
			_currentWeaponAttr = _dictWeaponAttr[WeaponTypeDefine.WEAPON_TYPE_MACHINE_GUN];
			
			_ammoPackage = new WeaponAmmoPackage();
			_ammoPackage.increaseWeaponAmmo( WeaponTypeDefine.WEAPON_TYPE_MACHINE_GUN, 10 );
			_ammoPackage.increaseWeaponAmmo( WeaponTypeDefine.WEAPON_TYPE_SHOT_GUN, 30 );
		}
		public function isValidChangetime():Boolean
		{
			return false;
		}
		public function isValidCDTime():Boolean
		{
			var bValidTime:Boolean = false;
			var currTime:Number = new Date().time;
			if ( _currentWeaponAttr != null )
			{
				if ( currTime - _currentChangeCDTime > _currentWeaponAttr.changeCD )
				{
					_currentChangeCDTime = currTime;
					bValidTime = true;
				}
			}
			return bValidTime;
		}
		public function canShoot():Boolean
		{
			var res:Boolean = false;
			if ( _currentWeaponAttr != null )
			{
				if ( _ammoPackage.hasEnoughAmmo( _currentWeaponAttr.weaponType ) )
				{
					if ( isValidCDTime() )
					{
						res = true;
					}
				}
			}
			return res;
		}
		public function shoot():void
		{
			if ( _currentWeaponAttr != null )
			{
				_ammoPackage.decreaseWeaponAmmo( _currentWeaponAttr.weaponType, 1 );
			}
		}
		public function canChangeWeapon( weaponTyp:uint ):Boolean
		{
			var res:Boolean = false;
			if ( isValidCDTime() )
			{
				if ( _ammoPackage[weaponTyp] != null )
				{
					res = true;
				}
			}
			return res;
		}
		public function changeWeapon( weaponTyp:uint ):Boolean
		{
			return true;
		}
	}

}