package gameplay.WeaponSystem.WeaponShoot 
{
	import gameplay.WeaponSystem.BulletAmmo.BaseBulletObject;
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
		public function WeaponShootShotGun() 
		{
			
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
			var bulletSprite:BaseBulletObject = new BaseBulletObject( _dspSystem );
			bulletSprite.loadGraphic( ImgBullet );
			bulletSprite.setSelfGroup( _bulletGroup );
			
			bulletSprite.x = startPoint.x;
			bulletSprite.y = startPoint.y;
			var widthLength:Number = endPoint.x - startPoint.x ;
			var heightLength:Number = endPoint.y - startPoint.y ;
			var rLength:Number = Math.sqrt( widthLength * widthLength + heightLength * heightLength );
			var sinAngle:Number = heightLength / rLength;
			var cosAngle:Number = widthLength / rLength;
			//var tnba:Number = Main.sin(90);
			var angleValue:Number = (Math.asin( sinAngle ) * 180 / Math.PI);
			var randomAngle:Number = 0;
			randomAngle = ( Math.random() - 0.5 ) * 10 ;
			var randomSin:Number = Math.sin( 90 );
			var randomCos:Number = Math.cos( angleValue + randomAngle );
			bulletSprite.weaponAttr = _weaponAttr;
			
			bulletSprite.velocity.x = randomCos * bulletSprite.weaponAttr.fireSpeed ;
			bulletSprite.velocity.y = randomSin * bulletSprite.weaponAttr.fireSpeed ;
		}
		
	}

}