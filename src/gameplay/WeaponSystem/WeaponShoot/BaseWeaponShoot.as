package gameplay.WeaponSystem.WeaponShoot 
{
	import gameplay.WeaponSystem.BulletAmmo.BaseBulletObject;
	import gameplay.WeaponSystem.BulletAmmo.BulletFactory;
	import gameplay.WeaponSystem.WeaponAttribute;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import util.EventDispatch.GameDispatchSystem;
	import gameEvent.sound.PlaySoundEvent;
	/**
	 * ...
	 * @author ddda
	 */	
	public class BaseWeaponShoot 
	{
		[Embed(source = "../../../../res/images/bullet.png")] protected static var ImgBullet:Class;
		protected var _startPoint:FlxPoint = new FlxPoint();
		protected var _endPoint:FlxPoint = new FlxPoint();
		protected var _bulletFactory:BulletFactory = null;
		public function BaseWeaponShoot( inBulletFactory:BulletFactory ) 
		{
			_bulletFactory = inBulletFactory;
		}
		
		protected function _supplyBullet( posX:Number, posY:Number ):BaseBulletObject
		{
			var bulletSprite:BaseBulletObject = _bulletFactory.SupplyBullet();
			bulletSprite.x = 0;
			bulletSprite.y = 0;
			bulletSprite.velocity.x = 0;
			bulletSprite.velocity.y = 0;
			bulletSprite.last.x = posX;
			bulletSprite.last.y = posY;
			return bulletSprite;
		}
		
		public function SetPosition( startX:Number, startY:Number, endX:Number, endY:Number ):void
		{
			_startPoint.x = startX;
			_startPoint.y = startY;
			_endPoint.x = endX;
			_endPoint.y = endY;
		}
		public function WeaponFire( _dspSystem:GameDispatchSystem,_bulletGroup:FlxGroup,_weaponAttr:WeaponAttribute ):void
		{
			_shootStrategy( _dspSystem, _startPoint, _endPoint, _bulletGroup, _weaponAttr );
			playSound(_dspSystem,_weaponAttr);
		}
		protected function _generateBulletObject( _dspSystem:GameDispatchSystem, startPoint:FlxPoint, endPoint:FlxPoint,_bulletGroup:FlxGroup,_weaponAttr:WeaponAttribute ):BaseBulletObject
		{
			var bulletSprite:BaseBulletObject = _supplyBullet( startPoint.x, startPoint.y );
			return _bulletSpec( bulletSprite,startPoint, endPoint, _bulletGroup, _weaponAttr );
		}

		protected function _shootStrategy( _dspSystem:GameDispatchSystem, startPoint:FlxPoint, endPoint:FlxPoint,_bulletGroup:FlxGroup,_weaponAttr:WeaponAttribute ):void
		{
			_generateBulletGroup( _dspSystem, startPoint, endPoint, _bulletGroup, _weaponAttr );
		}
		protected function _generateBulletGroup( _dspSystem:GameDispatchSystem, startPoint:FlxPoint, endPoint:FlxPoint, _bulletGroup:FlxGroup, _weaponAttr:WeaponAttribute ):void
		{
			_generateBulletObject( _dspSystem, startPoint, endPoint, _bulletGroup, _weaponAttr );
		}
		
		public function playSound( _dspSystem:GameDispatchSystem,_weaponAttr:WeaponAttribute ):void
		{
			var evt:PlaySoundEvent = new PlaySoundEvent( PlaySoundEvent.PLAY_SOUND_EVENT );
			evt.strSound = _weaponAttr.strSound;
			_dspSystem.DispatchEvent(evt);
		}
		protected function _bulletSpec( bulletSprite:BaseBulletObject,startPoint:FlxPoint, endPoint:FlxPoint,_bulletGroup:FlxGroup,_weaponAttr:WeaponAttribute ):BaseBulletObject
		{
			return bulletSprite;
		}
	}

}