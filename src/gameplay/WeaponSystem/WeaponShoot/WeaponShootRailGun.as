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
			bulletSprite.fill(0x000000);
			var xWidth:Number = 0;
			var yHeight:Number = 0;
			var posX:Number = 0;
			var posY:Number = 0;
			if ( startPoint.x - endPoint.x < 0 )
			{
				xWidth = FlxG.width - startPoint.x;
				posX = FlxG.width;
			}
			else
			{
				xWidth = startPoint.x;
				posX = 0;
			}
			if ( startPoint.y - endPoint.y < 0 )
			{
				yHeight = FlxG.height - startPoint.y;
				posY = FlxG.height;
			}
			else
			{
				yHeight = startPoint.y;
				posY = 0;
			}
			
			var endPosX:Number = 0;
			var endPosY:Number = 0;
			
			var widthLength:Number = endPoint.x - startPoint.x ;
			var heightLength:Number = endPoint.y - startPoint.y ;
			
			var tagAngle:Number = heightLength / widthLength;
			var ctagAngle:Number = widthLength / heightLength ;
			
			if ( xWidth > yHeight )
			{
				endPosY = posY;
				endPosX = -( ctagAngle * (startPoint.y - endPosY ) - startPoint.x );
			}
			else
			{
				endPosX = posX;
				endPosY = -( tagAngle * (startPoint.x - endPosX ) - startPoint.y );
			}
			
			
			bulletSprite.drawLine( startPoint.x , startPoint.y, endPosX, endPosY, 0xFFFF0000 );
			bulletSprite.setSelfGroup( _bulletGroup );
			bulletSprite.allowCollisions = 0;
			bulletSprite.weaponAttr = _weaponAttr;
		}
	}

}