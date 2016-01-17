package gameplay.WeaponSystem.WeaponShoot 
{
	import gameplay.WeaponSystem.BulletAmmo.BaseBulletObject;
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
		[Embed(source = "../../../../res/images/bullet.png")] private static var ImgBullet:Class;
		public function BaseWeaponShoot( startX:Number, startY:Number, endX:Number, endY:Number, weaponAttr:WeaponAttribute,_dspSystem:GameDispatchSystem, _bulletGroup:FlxGroup ) 
		{
			var startPoint:FlxPoint = new FlxPoint( startX, startY );
			var endPoint:FlxPoint = new FlxPoint( endX , endY );
			_generateBulletObject( _dspSystem, startPoint, endPoint,_bulletGroup, weaponAttr );
		}
		
		private function _generateBulletObject( _dspSystem:GameDispatchSystem, startPoint:FlxPoint, endPoint:FlxPoint,_bulletGroup:FlxGroup,_weaponAttr:WeaponAttribute ):void
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
			
			bulletSprite.weaponAttr = _weaponAttr;
			
			bulletSprite.velocity.x = cosAngle * bulletSprite.weaponAttr.fireSpeed ;
			bulletSprite.velocity.y = sinAngle * bulletSprite.weaponAttr.fireSpeed ;
		}
		
	}

}