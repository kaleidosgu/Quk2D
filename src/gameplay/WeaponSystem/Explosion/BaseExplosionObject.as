package gameplay.WeaponSystem.Explosion 
{
	import Base.BaseGameObject;
	import gamemap.GameObjectMainTyp;
	import player.BasePlayerObject;
	import util.Math.MathUtilTrigonometric;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BaseExplosionObject extends BaseGameObject 
	{
		private var _mathTrig:MathUtilTrigonometric = new MathUtilTrigonometric();
		private var _shiftMaxValue:Number = 1000;
		private var _shiftStageValue:uint = 3;
		private var _currentShiftState:uint = 1;
		public function BaseExplosionObject() 
		{
			_enableUpdateTick = true;
		}
		
		override public function getMainTyp():uint
		{
			return GameObjectMainTyp.GameObjectMainTyp_Explosion;
		}
		
		
		override public function collideByOtherObj( otherObj:BaseGameObject ):void
		{
			super.collideByOtherObj( otherObj );
			if ( otherObj is BasePlayerObject )
			{
				var basePlayer:BasePlayerObject = otherObj as BasePlayerObject;
				harmPlayer( basePlayer );
			}
			else
			{
				//todo 传递的不是player打log信息
			}
		}
		
		public function harmPlayer( basePlayer:BasePlayerObject ):void
		{
			_mathTrig.calculateAngBySize( this.getPrePoint().x, this.getPrePoint().y, this.width, this.height,
				basePlayer.x, basePlayer.y, basePlayer.width, basePlayer.height );
							
			var sinAng:Number = _mathTrig.sinAng;
			var cosAng:Number = _mathTrig.cosAng;
			
			var damageShift:Number = _currentShiftState * _shiftMaxValue / _shiftStageValue;
			var diffX:Number = cosAng * damageShift;
			var diffY:Number = sinAng * damageShift;
			basePlayer.velocity.x +=	diffX;
			basePlayer.velocity.y += 	diffY;
			removeFromGroup();
		}
		override protected function TickUpdateFunction():void
		{
			super.TickUpdateFunction();
			if ( _currentShiftState < _shiftStageValue )
			{
				_currentShiftState++;
			}
			else
			{
				removeFromGroup();
			}
		}
		
		public function get shiftMaxValue():Number 
		{
			return _shiftMaxValue;
		}
		
		public function set shiftMaxValue(value:Number):void 
		{
			_shiftMaxValue = value;
		}
		
		public function get shiftStageValue():uint 
		{
			return _shiftStageValue;
		}
		
		public function set shiftStageValue(value:uint):void 
		{
			_shiftStageValue = value;
		}
	}

}