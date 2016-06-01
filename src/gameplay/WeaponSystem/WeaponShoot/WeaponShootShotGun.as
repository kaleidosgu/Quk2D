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
		private var _diffDeg:Number = 50;
		
		private var _angleValueSin:Number = 0;
		private var _angleValueCos:Number = 0;
		private var _changeDelProcess:Boolean = false;
		public function WeaponShootShotGun( inBulletFactory:BulletFactory ) 
		{
			super( inBulletFactory );
		}
		override protected function _generateBulletGroup( _dspSystem:GameDispatchSystem, startPoint:FlxPoint, endPoint:FlxPoint, _bulletGroup:FlxGroup, _weaponAttr:WeaponAttribute ):void
		{
			_changeDelProcess = false;
			_generateDegFromPos(startPoint, endPoint);
			trace("####begin####");
			var degStart:Number = -30;
			for ( var idx:uint = 0; idx < 5; idx++ )
			{
				//degStart = 0;
				_generateBulletObjectShot( _dspSystem, startPoint, endPoint, _bulletGroup, _weaponAttr,degStart );
				degStart += 15;
			}
			trace("####end####");
			trace("													");
		}
		override protected function _bulletSpec( bulletSprite:BaseBulletObject, startPoint:FlxPoint, endPoint:FlxPoint, _bulletGroup:FlxGroup, _weaponAttr:WeaponAttribute ):BaseBulletObject
		{
			bulletSprite.loadGraphic( ImgBullet );
			bulletSprite.setSelfGroup( _bulletGroup );
			
			bulletSprite.x = startPoint.x;
			bulletSprite.y = startPoint.y;
			return bulletSprite;
		}
		override protected function _generateBulletObject( _dspSystem:GameDispatchSystem, startPoint:FlxPoint, endPoint:FlxPoint, _bulletGroup:FlxGroup, _weaponAttr:WeaponAttribute ):BaseBulletObject
		{
			return super._generateBulletObject( _dspSystem, startPoint, endPoint, _bulletGroup, _weaponAttr );
		}
		//right cos 0 ~ 180, sin -90 ~ 90
		protected function _generateBulletObjectShot( _dspSystem:GameDispatchSystem, startPoint:FlxPoint, endPoint:FlxPoint, 
		_bulletGroup:FlxGroup, _weaponAttr:WeaponAttribute, _degDiffStart:Number ):void
		{
			var bulletSprite:BaseBulletObject = _generateBulletObject(_dspSystem, startPoint, endPoint, _bulletGroup, _weaponAttr );
			
			var randomAddDeg:Number = 0;
			
			var numRandom:Number = Math.random();
			randomAddDeg = -(( numRandom - 0.5 ) * _diffDeg) ;
			var changeAngleDegSin:Number = 0;
			var changeAngleDegCos:Number = 0;
			/////////////////////////////
			//_degDiffStart = randomAddDeg;
			/////////////////////////////
			changeAngleDegSin = _angleValueSin + _degDiffStart;
			
			if ( _changeDelProcess == true )
			{
				_degDiffStart = 0 - _degDiffStart;
			}
			changeAngleDegCos = _angleValueCos + _degDiffStart;	
			trace("degSin [" + changeAngleDegSin + "]" + "  degCos [" + changeAngleDegCos + "]");
			
			var changeAngleRadSin:Number = changeAngleDegSin * Math.PI / 180;
			var changeAngleRadCos:Number = changeAngleDegCos * Math.PI / 180;
			
			
			var randomSin:Number = Math.sin( changeAngleRadSin );
			var randomCos:Number = Math.cos( changeAngleRadCos );
			
			bulletSprite.weaponAttr = _weaponAttr;
			
			bulletSprite.velocity.x = randomCos * bulletSprite.weaponAttr.fireSpeed ;
			bulletSprite.velocity.y = randomSin * bulletSprite.weaponAttr.fireSpeed ;
			
			var lastLength:Number = bulletSprite.velocity.x * bulletSprite.velocity.x + bulletSprite.velocity.y * bulletSprite.velocity.y;
			
			lastLength = Math.sqrt(lastLength);
			
			//trace("lastLngth" + lastLength);		
			//trace("randomCos " + randomCos + " randomSin " + randomSin );
		}
		private function _generateDegFromPos( startPoint:FlxPoint, endPoint:FlxPoint ):void
		{
			var widthLength:Number = endPoint.x - startPoint.x ;
			var heightLength:Number = endPoint.y - startPoint.y ;
			var widthLengthSqu:Number = widthLength * widthLength;
			var heightLengthSqu:Number = heightLength * heightLength;

			var rLengthSqu:Number = widthLength * widthLength + heightLength * heightLength;
			
			var rLength:Number = Math.sqrt( rLengthSqu );
			
			var sinAngle:Number = heightLength / rLength;
			var cosAngle:Number = widthLength / rLength;
			_angleValueSin = (Math.asin( sinAngle ) * 180 / Math.PI);
			_angleValueCos = (Math.acos( cosAngle ) * 180 / Math.PI);
			
			if ( heightLength * widthLength < 0 )
			{
				_changeDelProcess = true;
			}
		}
	}
}