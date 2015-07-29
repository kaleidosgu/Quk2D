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
		private var _staticWeaponAttribute:Object	= new Object();
		private var _currentChangeCDTime:Number 	= 0;
		private var _currentFireCDTime:Number		= 0;
		
		public function PlayerWeaponStatus() 
		{
			//TODO这里的数据需要通过读取静态数据更换掉
			var _tempWeaponStaticAttr:WeaponAttribute = new WeaponAttribute();
			_tempWeaponStaticAttr.changeCD	= 500;
			_staticWeaponAttribute[WeaponTypeDefine.WEAPON_TYPE_ROCKET_LAUNCHER] = _tempWeaponStaticAttr;
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
			var currWeaponStaticAttr:WeaponAttribute = _staticWeaponAttribute[_currentWeaponType];
			if ( currWeaponStaticAttr != null )
			{
				if ( currTime - _currentChangeCDTime > currWeaponStaticAttr.changeCD )
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