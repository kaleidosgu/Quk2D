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
	public class WeaponMachineGun extends BaseWeaponShoot 
	{
		[Embed(source = "../../../../res/images/bullet.png")] protected static var ImgBullet:Class;
		public function WeaponMachineGun( inBulletFactory:BulletFactory ) 
		{
			super(inBulletFactory);
		}
		override protected function _bulletSpec( bulletSprite:BaseBulletObject, startPoint:FlxPoint, endPoint:FlxPoint,_bulletGroup:FlxGroup,_weaponAttr:WeaponAttribute ):BaseBulletObject
		{
			if ( bulletSprite != null )
			{
				bulletSprite.loadGraphic( ImgBullet );
				bulletSprite.setSelfGroup( _bulletGroup );
				
				bulletSprite.x = startPoint.x;
				bulletSprite.y = startPoint.y;
				bulletSprite.last.x = startPoint.x;
				bulletSprite.last.y = startPoint.y;
				var widthLength:Number = endPoint.x - startPoint.x ;
				var heightLength:Number = endPoint.y - startPoint.y ;
				var rLength:Number = Math.sqrt( widthLength * widthLength + heightLength * heightLength );
				var sinAngle:Number = heightLength / rLength;
				var cosAngle:Number = widthLength / rLength;
				
				bulletSprite.weaponAttr = _weaponAttr;
				
				bulletSprite.velocity.x = cosAngle * bulletSprite.weaponAttr.fireSpeed;
				bulletSprite.velocity.y = sinAngle * bulletSprite.weaponAttr.fireSpeed;
			}
			return bulletSprite;
		}
	}

}