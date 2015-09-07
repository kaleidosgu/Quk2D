package gameplay.WeaponSystem 
{
	/**
	 * ...
	 * @author kaleidos
	 */
	public class PlayerWeaponStatus 
	{
		//TODO更改为原始初值
		//private var _currentWeaponType:uint 		= WEAPON_TYPE_NONE;
		private var _currentWeaponType:uint 		= WeaponTypeDefine.WEAPON_TYPE_ROCKET_LAUNCHER;
		private var _currentWeaponList:Object 		= new Object();
		private var _currentChangeCDTime:Number 	= 0;
		private var _currentFireCDTime:Number		= 0;
		
		private var _weaponLoader:WeaponAttributeLoadFromXml = null;
		private var _dictWeaponAttr:Object = new Object();
		private var _currentWeaponAttr:WeaponAttribute = null;
		public function PlayerWeaponStatus() 
		{
			_weaponLoader = new WeaponAttributeLoadFromXml();
			_weaponLoader.loadDataFromXml( _dictWeaponAttr );
			
			_currentWeaponAttr = _dictWeaponAttr[WeaponTypeDefine.WEAPON_TYPE_MACHINE_GUN];
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
		public function canChangeWeapon( dstWeaponType:uint ):Boolean
		{
			return false;
		}
	}

}