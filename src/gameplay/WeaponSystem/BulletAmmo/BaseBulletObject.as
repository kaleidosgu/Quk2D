package gameplay.WeaponSystem.BulletAmmo 
{
	import Base.BaseGameObject;
	import gameEvent.BattleEvent.BulletGenerateExplosionEvent;
	import gamemap.GameObjectMainTyp;
	import gameplay.WeaponSystem.WeaponAttribute;
	import player.BasePlayerObject;
	import util.EventDispatch.GameDispatchSystem;
	import util.Math.MathUtilTrigonometric;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BaseBulletObject extends BaseGameObject 
	{
		private var _weaponAttr:WeaponAttribute = null;
		private var _mathTrig:MathUtilTrigonometric = new MathUtilTrigonometric();
		private var _dspSys:GameDispatchSystem = null;
		public function BaseBulletObject( inDspSys:GameDispatchSystem ) 
		{
			_dspSys = inDspSys;
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
			if ( _weaponAttr != null )
			{
				if ( _weaponAttr.damageFields <= 0 )
				{
					_mathTrig.calculateAngBySize( this.getPrePoint().x, this.getPrePoint().y, this.width, this.height,
					basePlayer.x, basePlayer.y, basePlayer.width, basePlayer.height );
									
					var sinAng:Number = _mathTrig.sinAng;
					var cosAng:Number = _mathTrig.cosAng;
					
					var diffX:Number = cosAng * _weaponAttr.damageShift;
					var diffY:Number = sinAng * _weaponAttr.damageShift;
					basePlayer.velocity.x +=	 diffX;
					basePlayer.velocity.y += 	 diffY;	
				}
			}
		}
		private function generateExplosion():void
		{
			if ( _weaponAttr != null )
			{
				if ( _weaponAttr.damageFields > 0 )
				{
					var generatePosX:Number = this.x + this.width / 2;
					var generatePosY:Number = this.y + this.height / 2
					
					var genExpEvt:BulletGenerateExplosionEvent = new BulletGenerateExplosionEvent( BulletGenerateExplosionEvent.BULLET_GENERATE_EXPLOSION_EVENT );

					genExpEvt.posX = generatePosX;
					genExpEvt.posY = generatePosY;
					genExpEvt.weaponType = _weaponAttr.weaponType;
					_dspSys.DispatchEvent( genExpEvt );
				}
			}
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
			generateExplosion();
		}
	}

}