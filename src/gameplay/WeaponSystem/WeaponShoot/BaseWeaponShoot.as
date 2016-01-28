package gameplay.WeaponSystem.WeaponShoot 
{
	import gameplay.WeaponSystem.BulletAmmo.BaseBulletObject;
	import gameplay.WeaponSystem.BulletAmmo.BulletFactory;
	import gameplay.WeaponSystem.WeaponAttribute;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import util.EventDispatch.GameDispatchSystem;
	/**
	 * ...
	 * @author ddda
	 */	
	public class BaseWeaponShoot 
	{
		[Embed(source = "../../../../res/images/bullet.png")] protected static var ImgBullet:Class;
		private var _startPoint:FlxPoint = new FlxPoint();
		private var _endPoint:FlxPoint = new FlxPoint();
		private var _bulletFactory:BulletFactory = null;
		public function BaseWeaponShoot( inBulletFactory:BulletFactory ) 
		{
			_bulletFactory = inBulletFactory;
		}
		
		protected function _supplyBullet():BaseBulletObject
		{
			var bulletSprite:BaseBulletObject = _bulletFactory.SupplyBullet();
			bulletSprite.x = 0;
			bulletSprite.y = 0;
			bulletSprite.velocity.x = 0;
			bulletSprite.velocity.y = 0;
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
		}
		private function _generateBulletObject( _dspSystem:GameDispatchSystem, startPoint:FlxPoint, endPoint:FlxPoint,_bulletGroup:FlxGroup,_weaponAttr:WeaponAttribute ):void
		{
			var bulletSprite:BaseBulletObject = _supplyBullet();
			bulletSprite.loadGraphic( ImgBullet );
			bulletSprite.setSelfGroup( _bulletGroup );
			
			bulletSprite.x = startPoint.x;
			bulletSprite.y = startPoint.y;
			var widthLength:Number = endPoint.x - startPoint.x ;
			var heightLength:Number = endPoint.y - startPoint.y ;
			var rLength:Number = Math.sqrt( widthLength * widthLength + heightLength * heightLength );
			var sinAngle:Number = heightLength / rLength;
			var cosAngle:Number = widthLength / rLength;
			
			bulletSprite.weaponAttr = _weaponAttr;
			
			bulletSprite.velocity.x = cosAngle * bulletSprite.weaponAttr.fireSpeed;
			bulletSprite.velocity.y = sinAngle * bulletSprite.weaponAttr.fireSpeed;
		}
		
		
		protected function _shootStrategy( _dspSystem:GameDispatchSystem, startPoint:FlxPoint, endPoint:FlxPoint,_bulletGroup:FlxGroup,_weaponAttr:WeaponAttribute ):void
		{
			_generateBulletObject( _dspSystem, startPoint, endPoint, _bulletGroup, _weaponAttr );
		}
	}

}