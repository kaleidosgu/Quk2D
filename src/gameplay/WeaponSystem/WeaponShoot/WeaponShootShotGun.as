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
	 * @author kaleidos
	 */
	public class WeaponShootShotGun extends BaseWeaponShoot 
	{
		[Embed(source = "../../../../res/images/bullet.png")] protected static var ImgBullet:Class;
		private var _startPoint:FlxPoint = new FlxPoint();
		private var _endPoint:FlxPoint = new FlxPoint();
		private var _diffDeg:Number = 20;
		public function WeaponShootShotGun( inBulletFactory:BulletFactory ) 
		{
			super( inBulletFactory );
		}
		override protected function _shootStrategy( _dspSystem:GameDispatchSystem, startPoint:FlxPoint, endPoint:FlxPoint,_bulletGroup:FlxGroup,_weaponAttr:WeaponAttribute ):void
		{
			for ( var idx:uint = 0; idx < 5; idx++ )
			{
				_generateBulletObject( _dspSystem, startPoint, endPoint,_bulletGroup, _weaponAttr );	
			}
		}
		private function _generateBulletObject( _dspSystem:GameDispatchSystem, startPoint:FlxPoint, endPoint:FlxPoint, _bulletGroup:FlxGroup, _weaponAttr:WeaponAttribute ):void
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
			
			var angleValueSin:Number = (Math.asin( sinAngle ) * 180 / Math.PI);
			var angleValueCos:Number = (Math.acos( cosAngle ) * 180 / Math.PI);
			var randomAddDeg:Number = 0;
			
			randomAddDeg = -(( Math.random() - 0.5 ) * _diffDeg) ;
			var changeAngleDegSin:Number = angleValueSin + randomAddDeg;
			var changeAngleDegCos:Number = angleValueCos + randomAddDeg;
			
			var changeAngleRadSin:Number = changeAngleDegSin * Math.PI / 180;
			var changeAngleRadCos:Number = changeAngleDegCos * Math.PI / 180;
			var randomSin:Number = Math.sin( changeAngleRadSin );
			var randomCos:Number = Math.cos( changeAngleRadCos );
			bulletSprite.weaponAttr = _weaponAttr;
			
			bulletSprite.velocity.x = randomCos * bulletSprite.weaponAttr.fireSpeed ;
			bulletSprite.velocity.y = randomSin * bulletSprite.weaponAttr.fireSpeed ;
		}
	}
}