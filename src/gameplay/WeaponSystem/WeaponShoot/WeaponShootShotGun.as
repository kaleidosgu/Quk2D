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
		private var _diffDeg:Number = 50;
		public function WeaponShootShotGun( inBulletFactory:BulletFactory ) 
		{
			super( inBulletFactory );
		}
		override protected function _shootStrategy( _dspSystem:GameDispatchSystem, startPoint:FlxPoint, endPoint:FlxPoint,_bulletGroup:FlxGroup,_weaponAttr:WeaponAttribute ):void
		{
			trace("####begin####");
			var degStart:Number = -30;
			for ( var idx:uint = 0; idx < 5; idx++ )
			{
				//degStart = 0;
				_generateBulletObject( _dspSystem, startPoint, endPoint, _bulletGroup, _weaponAttr,degStart );
				degStart += 15;
			}
			trace("####end####");
		}
		//right cos 0 ~ 180, sin -90 ~ 90
		private function _generateBulletObject( _dspSystem:GameDispatchSystem, startPoint:FlxPoint, endPoint:FlxPoint, 
		_bulletGroup:FlxGroup, _weaponAttr:WeaponAttribute, _degDiff:Number ):void
		{
			var bulletSprite:BaseBulletObject = _supplyBullet();
			bulletSprite.loadGraphic( ImgBullet );
			bulletSprite.setSelfGroup( _bulletGroup );
			
			bulletSprite.x = startPoint.x;
			bulletSprite.y = startPoint.y;
			var widthLength:Number = endPoint.x - startPoint.x ;
			var heightLength:Number = endPoint.y - startPoint.y ;
			var widthLengthSqu:Number = widthLength * widthLength;
			var heightLengthSqu:Number = heightLength * heightLength;

			var rLengthSqu:Number = widthLength * widthLength + heightLength * heightLength;
			
			//widthLength = -1;
			//heightLength = 1;
			//rLengthSqu = 2;
			
			var rLength:Number = Math.sqrt( rLengthSqu );
			
			var sinAngle:Number = heightLength / rLength;
			var cosAngle:Number = widthLength / rLength;
			var angleValueSin:Number = (Math.asin( sinAngle ) * 180 / Math.PI);
			var angleValueCos:Number = (Math.acos( cosAngle ) * 180 / Math.PI);
			//计算角度可以放在外部进行。以提高效率
			
			
			var randomAddDeg:Number = 0;
			
			var numRandom:Number = Math.random();
			randomAddDeg = -(( numRandom - 0.5 ) * _diffDeg) ;
			//var changeAngleDegSin:Number = angleValueSin + randomAddDeg;
			//var changeAngleDegCos:Number = angleValueCos + randomAddDeg;
			var changeAngleDegSin:Number = 0;
			var changeAngleDegCos:Number = 0;
			changeAngleDegSin = angleValueSin + _degDiff;
			
			if ( heightLength * widthLength < 0 )
			{
				_degDiff = 0 - _degDiff;
			}
			
			changeAngleDegCos = angleValueCos + _degDiff;
			trace("degSin [" + changeAngleDegSin + "]" + "  degCos [" + changeAngleDegCos + "]");
			
			var changeAngleRadSin:Number = changeAngleDegSin * Math.PI / 180;
			var changeAngleRadCos:Number = changeAngleDegCos * Math.PI / 180;
			//var changeAngleRadSin:Number = _degDiff * Math.PI / 180;
			//var changeAngleRadCos:Number = _degDiff * Math.PI / 180;
			//changeAngleRadSin = (-80 + _degDiff ) * Math.PI / 180;
			
			
			var randomSin:Number = Math.sin( changeAngleRadSin );
			var randomCos:Number = Math.cos( changeAngleRadCos );
			//notice radians
			//randomSin = Math.sin( 180 * Math.PI / 180 );
			//randomCos = Math.cos( 180 * Math.PI / 180 );
			bulletSprite.weaponAttr = _weaponAttr;
			
			bulletSprite.velocity.x = randomCos * bulletSprite.weaponAttr.fireSpeed ;
			bulletSprite.velocity.y = randomSin * bulletSprite.weaponAttr.fireSpeed ;
			
			var lastLength:Number = bulletSprite.velocity.x * bulletSprite.velocity.x + bulletSprite.velocity.y * bulletSprite.velocity.y;
			
			lastLength = Math.sqrt(lastLength);
			
			trace("lastLngth" + lastLength);
			
			trace("													");
			
			//trace("randomCos " + randomCos + " randomSin " + randomSin );
		}
	}
}