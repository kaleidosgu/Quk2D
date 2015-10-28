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
			if ( _weaponAttr != null )
			{
				var srcPreX:Number = this.getPrePoint().x + this.width / 2;
				var srcPreY:Number = this.getPrePoint().y + this.height / 2;
				
				var dstX:Number = basePlayer.x + basePlayer.width / 2;
				var dstY:Number = basePlayer.y + basePlayer.height / 2;
				
				var newWidth:Number = dstX - srcPreX;
				var newHeight:Number = dstY - srcPreY;
				
				var rLength:Number = Math.sqrt( newWidth * newWidth + newHeight * newHeight );
				
				var sinAng:Number = newHeight / rLength;
				var cosAng:Number = newWidth  / rLength;
				
				var diffX:Number = cosAng * _weaponAttr.damageShift;
				var diffY:Number = sinAng * _weaponAttr.damageShift;
				basePlayer.velocity.x += diffX;
				basePlayer.velocity.y += diffY;
			}
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
			removeFromGroup();
		}
	}

}