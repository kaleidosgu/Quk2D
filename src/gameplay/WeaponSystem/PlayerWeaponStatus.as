package gameplay.WeaponSystem 
{
	import gameEvent.sound.PlaySoundEvent;
	import util.EventDispatch.GameDispatchSystem;
	/**
	 * ...
	 * @author kaleidos
	 */
	//test git hub
	public class PlayerWeaponStatus 
	{
		private var _currentWeaponList:Object 		= new Object();
		private var _currentChangeCDTime:Number 	= 0;
		private var _currentFireCDTime:Number		= 0;
		
		private var _currentWeaponAttr:WeaponAttribute = null;
		
		private var _ammoPackage:WeaponAmmoPackage = null;
		private var _xmlLoader:WeaponAttributeLoadFromXml = null;
		private var _arrayWeaponType:Array = new Array();
		private var _inDspSyste:GameDispatchSystem = null;
		public function PlayerWeaponStatus( inXmlLoader:WeaponAttributeLoadFromXml,_dspSystem:GameDispatchSystem  ) 
		{
			_ammoPackage = new WeaponAmmoPackage();
			_arrayWeaponType.push( WeaponTypeDefine.WEAPON_TYPE_MACHINE_GUN );
			_arrayWeaponType.push( WeaponTypeDefine.WEAPON_TYPE_SHOT_GUN );
			_arrayWeaponType.push( WeaponTypeDefine.WEAPON_TYPE_RAIL_GUN );
			
			for each( var weaponType:uint in _arrayWeaponType )
			{
				_ammoPackage.increaseWeaponAmmo( weaponType, inXmlLoader.GetWeaponInitCounts( weaponType ) );
			}
			_xmlLoader = inXmlLoader;
			
			_currentWeaponAttr = _xmlLoader.getWeaponAttr( WeaponTypeDefine.WEAPON_TYPE_MACHINE_GUN );
			_inDspSyste = _dspSystem;
			
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
				if ( isValidCDTime() )
				{
					if ( _ammoPackage.hasEnoughAmmo( _currentWeaponAttr.weaponType ) )
					{
						if ( _isFireCDValid() )
						{
							res = true;
						}
					}
					else
					{
						var evt:PlaySoundEvent = new PlaySoundEvent(PlaySoundEvent.PLAY_SOUND_EVENT);
						evt.strSound = "noammo";
						_inDspSyste.DispatchEvent(evt);
					}
				}
			}
			return res;
		}
		private function _isFireCDValid():Boolean
		{
			var bValidTime:Boolean = false;
			var currTime:Number = new Date().time;
			if ( _currentWeaponAttr != null )
			{
				var numResult:Number = currTime - _currentFireCDTime;
				if ( numResult > _currentWeaponAttr.fireCD )
				{
					_currentFireCDTime = currTime;
					bValidTime = true;
				}
			}
			return bValidTime;
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
			if ( _currentWeaponAttr != null )
			{
				if ( _currentWeaponAttr.weaponType != weaponTyp )
				{
					var tmpWeaponAttr:WeaponAttribute = _xmlLoader.getWeaponAttr(weaponTyp);
					if ( tmpWeaponAttr != null )
					{
						if ( isValidCDTime() )
						{
							if ( _ammoPackage.hasWeapon( weaponTyp ) )
							{
								res = true;
							}
						}
					}
				}
			}
			return res;
		}
		public function changeWeapon( weaponTyp:uint ):Boolean
		{
			var tmpWeaponAttr:WeaponAttribute = _xmlLoader.getWeaponAttr(weaponTyp);
			if ( tmpWeaponAttr != null )
			{
				_currentWeaponAttr = tmpWeaponAttr;
			}
			return true;
		}
		public function currentWeaponAttr():WeaponAttribute
		{
			return _currentWeaponAttr;
		}
	}

}