package gameplay.WeaponSystem.BulletAmmo 
{
	import Base.BaseGameObject;
	import gamemap.GameObjectMainTyp;
	import gameplay.WeaponSystem.WeaponAttribute;
	import player.BasePlayerObject;
	import util.Math.MathUtilTrigonometric;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BaseBulletObject extends BaseGameObject 
	{
		private var _weaponAttr:WeaponAttribute = null;
		private var _mathTrig:MathUtilTrigonometric = new MathUtilTrigonometric();
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
				_mathTrig.calculateAngBySize( this.getPrePoint().x, this.getPrePoint().y, this.width, this.height,
				basePlayer.x, basePlayer.y, basePlayer.width, basePlayer.height );
								
				var sinAng:Number = _mathTrig.sinAng;
				var cosAng:Number = _mathTrig.cosAng;
				
				var diffX:Number = cosAng * _weaponAttr.damageShift;
				var diffY:Number = sinAng * _weaponAttr.damageShift;
				basePlayer.velocity.x +=	 diffX;
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
		}
	}

}