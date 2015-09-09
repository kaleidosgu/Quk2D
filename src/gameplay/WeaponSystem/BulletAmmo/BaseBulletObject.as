package gameplay.WeaponSystem.BulletAmmo 
{
	import Base.BaseGameObject;
	import gamemap.GameObjectMainTyp;
	import gameplay.WeaponSystem.WeaponAttribute;
	import player.BasePlayerObject;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BaseBulletObject extends BaseGameObject 
	{
		private var _weaponAttr:WeaponAttribute = null;
		public function BaseBulletObject() 
		{
		}
		
		override public function getMainTyp():uint
		{
			return GameObjectMainTyp.GameObjectMainTyp_Bullet;
		}
		public function harmPlayer( basePlayer:BasePlayerObject ):void
		{
			
		}
		public function shiftPosPlayer( basePlayer:BasePlayerObject ):void
		{
			
		}
		public function destroySelf():void
		{
			removeFromGroup();
		}
		
		public function get weaponAttr():WeaponAttribute 
		{
			return _weaponAttr;
		}
		
		public function set weaponAttr(value:WeaponAttribute):void 
		{
			_weaponAttr = value;
		}
		override public function collideByOtherObj( otherObj:BaseGameObject ):void
		{
			super.collideByOtherObj( otherObj );
			removeFromGroup();
			if ( otherObj is BasePlayerObject )
			{
				var basePlayer:BasePlayerObject = otherObj as BasePlayerObject;
				harmPlayer( basePlayer );
				shiftPosPlayer( basePlayer );
			}
			else
			{
				//todo 传递的不是player打log信息
			}
		}
	}

}