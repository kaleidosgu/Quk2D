package gameplay.WeaponSystem.WeaponShoot 
{
	import gameplay.WeaponSystem.BulletAmmo.BaseBulletObject;
	import gameplay.WeaponSystem.WeaponAttribute;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import util.EventDispatch.GameDispatchSystem;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class WeaponShootRailGun extends BaseWeaponShoot 
	{
		
		public function WeaponShootRailGun() 
		{
			
		}
		
		override protected function _shootStrategy( _dspSystem:GameDispatchSystem, startPoint:FlxPoint, endPoint:FlxPoint,_bulletGroup:FlxGroup,_weaponAttr:WeaponAttribute ):void
		{
			_generateBulletObject( _dspSystem, startPoint, endPoint,_bulletGroup, _weaponAttr );	
		}
		private function _generateBulletObject( _dspSystem:GameDispatchSystem, startPoint:FlxPoint, endPoint:FlxPoint, _bulletGroup:FlxGroup, _weaponAttr:WeaponAttribute ):void
		{
			var bulletSprite:BaseBulletObject = new BaseBulletObject( _dspSystem );
			bulletSprite.makeGraphic(FlxG.width, FlxG.height, 0x22000000 );
			bulletSprite.drawLine( startPoint.x , startPoint.y, endPoint.x, endPoint.y, 0xFFFF0000 );
			bulletSprite.setSelfGroup( _bulletGroup );
			bulletSprite.allowCollisions = 0;
			bulletSprite.weaponAttr = _weaponAttr;
		}
	}

}