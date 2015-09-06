package gameplay.WeaponSystem 
{
	/**
	 * ...
	 * @author kaleidos
	 */
	public class WeaponAttribute 
	{
		private var _weaponType:uint		= 0;	//武器类型
		private var _fireSpeed:Number 		= 0;	//射速
		private var _damageValue:uint		= 0;	//伤害
		private var _countsPerFire:uint		= 0;	//每次发射数量
		private var _damageShift:Number		= 0;	//伤害产生位移
		private var _reboundCounts:uint		= 0;	//反弹次数。如果是0则不反弹
		private var _damageFields:Number	= 0;	//伤害范围
		private var _fireRange:Number		= 0;	//射程
		private var _linearShape:Boolean	= false;//线性形状
		private var _changeCD:Number		= 0;	//换弹CD
		private var _fireCD:Number			= 0;	//发射CD
		public function WeaponAttribute() 
		{
			
		}
		
		public function get fireSpeed():Number 
		{
			return _fireSpeed;
		}
		
		public function set fireSpeed(value:Number):void 
		{
			_fireSpeed = value;
		}
		
		public function get damageValue():uint 
		{
			return _damageValue;
		}
		
		public function set damageValue(value:uint):void 
		{
			_damageValue = value;
		}
		
		public function get countsPerFire():uint 
		{
			return _countsPerFire;
		}
		
		public function set countsPerFire(value:uint):void 
		{
			_countsPerFire = value;
		}
		
		public function get damageShift():Number 
		{
			return _damageShift;
		}
		
		public function set damageShift(value:Number):void 
		{
			_damageShift = value;
		}
		
		public function get reboundCounts():uint 
		{
			return _reboundCounts;
		}
		
		public function set reboundCounts(value:uint):void 
		{
			_reboundCounts = value;
		}
		
		public function get damageFields():Number 
		{
			return _damageFields;
		}
		
		public function set damageFields(value:Number):void 
		{
			_damageFields = value;
		}
		
		public function get fireRange():Number 
		{
			return _fireRange;
		}
		
		public function set fireRange(value:Number):void 
		{
			_fireRange = value;
		}
		
		public function get linearShape():Boolean 
		{
			return _linearShape;
		}
		
		public function set linearShape(value:Boolean):void 
		{
			_linearShape = value;
		}
		
		public function get changeCD():Number 
		{
			return _changeCD;
		}
		
		public function set changeCD(value:Number):void 
		{
			_changeCD = value;
		}
		
		public function get fireCD():Number 
		{
			return _fireCD;
		}
		
		public function set fireCD(value:Number):void 
		{
			_fireCD = value;
		}
		
		public function get weaponType():uint 
		{
			return _weaponType;
		}
		
		public function set weaponType(value:uint):void 
		{
			_weaponType = value;
		}
		
	}

}