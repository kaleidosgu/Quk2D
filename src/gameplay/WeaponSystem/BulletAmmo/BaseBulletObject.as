package gameplay.WeaponSystem.BulletAmmo 
{
	import Base.BaseGameObject;
	import gameEvent.BattleEvent.BulletGenerateExplosionEvent;
	import gamemap.Building.BaseBuildingObject;
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
		private var _currentDestroyCounts:uint = 1;
		private var _constDestroyCounts:uint = 0;
		private var _bulletFactory:BulletFactory = null;
		public function BaseBulletObject( inDspSys:GameDispatchSystem, inBulletFactory:BulletFactory ) 
		{
			_dspSys = inDspSys;
			_enableUpdateTick = true;
			_bulletFactory = inBulletFactory;
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
			_bulletFactory.RecycleBullet( this );
		}
		
		public function get weaponAttr():WeaponAttribute 
		{
			return _weaponAttr;
		}
		
		public function set weaponAttr(value:WeaponAttribute):void 
		{
			_weaponAttr = value;
			_constDestroyCounts = _weaponAttr.destroySelfCounts;
			_currentDestroyCounts = 1;
		}
		override public function collideByOtherObj( otherObj:BaseGameObject ):void
		{
			var bGenerateExplosion:Boolean = false;
			super.collideByOtherObj( otherObj );
			if ( otherObj is BasePlayerObject )
			{
				var basePlayer:BasePlayerObject = otherObj as BasePlayerObject;
				harmPlayer( basePlayer );
				shiftPosPlayer( basePlayer );
				destroySelf();
				bGenerateExplosion = true;
			}
			else
			{
				if ( otherObj.getMainTyp() == GameObjectMainTyp.GameObjectMainTyp_Building )
				{
					var buildingObj:BaseBuildingObject = otherObj as BaseBuildingObject;
					if ( buildingObj.gameObjData.canCollide == true )
					{
						bGenerateExplosion = true;
					}
				}
				//todo 传递的不是player打log信息
			}
			if ( bGenerateExplosion == true )
			{
				generateExplosion();	
			}
		}
		override protected function TickUpdateFunction():void
		{
			super.TickUpdateFunction();
			if ( _constDestroyCounts > 0 )
			{
				if ( _currentDestroyCounts < _constDestroyCounts )
				{
					_currentDestroyCounts++;
				}
				else
				{
					//removeFromGroup();
					destroySelf();
				}
			}
		}
	}

}